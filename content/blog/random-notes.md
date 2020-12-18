+++
author = "Xing Lin"
title = "Random Notes"
description = ""
tags = [
    "notes",
]
date = "2020-09-27"
+++

Isolation is the property that provides guarantees in the concurrent accesses to data. Isolation is implemented by means of a concurrency control protocol. The simplest way is to make all readers wait until the writer is done, which is known as a read-write lock. Locks are known to create contention especially between long read transactions and update transactions. MVCC aims at solving the problem by keeping multiple copies of each data item. In this way, each user connected to the database sees a snapshot of the database at a particular instant in time. Any changes made by a writer will not be seen by other users of the database until the changes have been completed (or, in database terms: until the transaction has been committed.)