+++
author = "Xing Lin"
title = "Transaction"
description = ""
tags = [
    "note", "transaction", "acid"
]
date = "2020-09-27"
+++

The four properties that a transaction in the database world has are ACID: A stands for atomicity, C for consistency, I for isolation and D for durability. 

| Property | Definition | Technique to achieve that property |
| :------: | :--:|:--:|
| Atomicity| A transaction either succeeds or fails as a single operation. | Undo log | 
| Consistency | A database should start in a consistent state and end in another consistent state, after applying a transaction or transactions. | Undo log|
| Isolation | Each transaction should be executed as if it was the only transaction that is running. Transactions are isolated and are not aware of each other. Allowing concurrent transactions. | 2-phase locking or MVCC | 
| Durability | Writes made to the database will survive system failures. | Redo log | 

Quota from Design Data-Intensive Applications book. 

* Isolation is the property that provides guarantees in the concurrent accesses to data. Isolation is implemented by means of a concurrency control protocol. The simplest way is to make all readers wait until the writer is done, which is known as a read-write lock. Locks are known to create contention especially between long read transactions and update transactions. MVCC aims at solving the problem by keeping multiple copies of each data item. In this way, each user connected to the database sees a snapshot of the database at a particular instant in time. Any changes made by a writer will not be seen by other users of the database until the changes have been completed (or, in database terms: until the transaction has been committed.)

[知乎link][acdlink]
> ACD三个特性是通过Redo log（重做日志）和Undo log 实现的。 而隔离性是通过锁来实现的。  
> 重做日志用来实现事务的持久性，即D特性.  
> Undo log (MySQL):  
>   1. 实现事务回滚
>   2. 实现MVCC

[acdlink]: https://zhuanlan.zhihu.com/p/48327345