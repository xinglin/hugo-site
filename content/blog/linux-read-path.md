+++
author = "Xing Lin"
title = "Read Path in Linux Kernel"
description = "Read path in the Linux kernel"
tags = [
    "engineering",
    "linux",
    "source code",
]
date = "2019-01-16"
+++

[A tour of the Linux VFS][vfs]

```
ext2_file_read_iter(): ext2_file_operations.read_iter
    generic_file_read_iter()
        generic_file_buffered_read()
            page_cache_sync_readahead()
                force_page_cache_readahead()
                    __do_page_cache_readahead()
                        __page_cache_alloc()
                        read_pages()
                            mapping->a_ops->readpages(filp, mapping, pages, nr_pages);
                            or mapping->a_ops->readpage(filp, page);
```

# readpages for ext2
```
ext2_readpages()
    mpage_readpages()
        mpage_bio_submit()
```
  

```
__do_page_cache_readahead()
{
    for (page_idx = 0; page_idx < nr_to_read; page_idx++) {
        __page_cache_alloc();
    }

    if (nr_pages)
		read_pages(mapping, filp, &page_pool, nr_pages, gfp_mask);
}


/*
 * __do_page_cache_readahead() actually reads a chunk of disk.  It allocates
 * the pages first, then submits them for I/O. This avoids the very bad
 * behaviour which would occur if page allocations are causing VM writeback.
 * We really don't want to intermingle reads and writes like that.
 *
 * Returns the number of pages requested, or the maximum amount of I/O allowed.
 */
unsigned int __do_page_cache_readahead(struct address_space *mapping,
		struct file *filp, pgoff_t offset, unsigned long nr_to_read,
		unsigned long lookahead_size)
{
    ...

	/*
	 * Preallocate as many pages as we will need.
	 */
	for (page_idx = 0; page_idx < nr_to_read; page_idx++) {
		pgoff_t page_offset = offset + page_idx;

		if (page_offset > end_index)
			break;

		page = xa_load(&mapping->i_pages, page_offset);
		if (page && !xa_is_value(page)) {
			/*
			 * Page already present?  Kick off the current batch of
			 * contiguous pages before continuing with the next
			 * batch.
			 */
			if (nr_pages)
				read_pages(mapping, filp, &page_pool, nr_pages,
						gfp_mask);
			nr_pages = 0;
			continue;
		}

		page = __page_cache_alloc(gfp_mask);
		if (!page)
			break;
		page->index = page_offset;
		list_add(&page->lru, &page_pool);
		if (page_idx == nr_to_read - lookahead_size)
			SetPageReadahead(page);
		nr_pages++;
	}  


	/*
	 * Now start the IO.  We ignore I/O errors - if the page is not
	 * uptodate then the caller will launch readpage again, and
	 * will then handle the error.
	 */
	if (nr_pages)
		read_pages(mapping, filp, &page_pool, nr_pages, gfp_mask);
}

static int read_pages(struct address_space *mapping, struct file *filp,
		struct list_head *pages, unsigned int nr_pages, gfp_t gfp)
{
	struct blk_plug plug;
	unsigned page_idx;
	int ret;

	blk_start_plug(&plug);

	if (mapping->a_ops->readpages) {
		ret = mapping->a_ops->readpages(filp, mapping, pages, nr_pages);
		/* Clean up the remaining pages */
		put_pages_list(pages);
		goto out;
	}

	for (page_idx = 0; page_idx < nr_pages; page_idx++) {
		struct page *page = lru_to_page(pages);
		list_del(&page->lru);
		if (!add_to_page_cache_lru(page, mapping, page->index, gfp))
			mapping->a_ops->readpage(filp, page);
		put_page(page);
	}
	ret = 0;

out:
	blk_finish_plug(&plug);

	return ret;
}
```

# ext2 address space operations table
```
const struct address_space_operations ext2_aops = {
	.readpage		= ext2_readpage,
	.readpages		= ext2_readpages,
	.writepage		= ext2_writepage,
	.write_begin		= ext2_write_begin,
	.write_end		= ext2_write_end,
	.bmap			= ext2_bmap,
	.direct_IO		= ext2_direct_IO,
	.writepages		= ext2_writepages,
	.migratepage		= buffer_migrate_page,
	.is_partially_uptodate	= block_is_partially_uptodate,
	.error_remove_page	= generic_error_remove_page,
};
```

[vfs]: http://www.tldp.org/LDP/khg/HyperNews/get/fs/vfstour.html