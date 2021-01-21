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
The purpose of transactions is to maintain data in the face of concurrent access and system failures.

| Property | Definition | Technique to achieve that property |
| :------: | :--:|:--:|
| Atomicity| A transaction either succeeds or fails as a single operation. | Undo log | 
| Consistency | A database should start in a consistent state and end in another consistent state, after applying a transaction or transactions. | Relies on the other three properties. |
| Isolation | Each transaction should be executed as if it was the only transaction that is running. Transactions are isolated and are not aware of each other. Allowing concurrent transactions. | 2-phase locking or MVCC | 
| Durability | Writes made to the database will survive system failures. | Redo log | 

## Database Management Systems

* Strict Two-Phase Locking (Strict 2PL)  
>   Rule 1. If a transaction T wants to read (respectively, modify) an object, it first requests 
>           a shared (respectively, exclusive) lock on the object.  
>   Rule 2. All locks held by a transaction are released **when the transaction is completed**.
>   
>   If two transactions access the same object, and one wants to modify it, their actions are 
>   effectively ordered serially: all actions of one of these transactions (the one that gets 
>   the lock on the common object first) are completed before (this lock is released and) the 
>   other transaction can proceed.

* Two-Phase Locking (2PL)  
>   Rule 1. If a transaction T wants to read (respectively, modify) an object, it first requests 
>           a shared (respectively, exclusive) lock on the object (same as strict 2PL).  
>   Rule 2. **A transaction cannot request additional locks once it releases any lock**.

* Recovery Manager  
>   The recovery manager of a DBMS is responsible for ensuring transaction atomicity and 
>   durability. It ensures atomicity by undoing the actions of transactions that do not commit, 
>   and durability by making sure that all actions of committed transactions survive systenl 
>   crashes, (e.g., a core dump caused by a bus error) and media failures (e.g., a disk is 
>   corrupted).

* Lock Implementation in DBMS  
>   The lock manager maintains a lock table, which is a hash table with the data object 
>   identifier as the key.  
>   A lock table entry for an object -- which can be a page, a record, and so on, depending on the DBMS -- contains the following inforrnation: the number of transactions currently holding a. lock on the object (this can be more than one if the object is locked in shared mode), the nature of the lock (shared or exclusive), and a pointer to the queue of lock requests.

## Design Data-Intensive Applications book. 

>   Isolation is the property that provides guarantees in the concurrent accesses to data. Isolation is implemented by means of a concurrency control protocol. The simplest way is to make all readers wait until the writer is done, which is known as a read-write lock. Locks are known to create contention especially between long read transactions and update transactions. MVCC aims at solving the problem by keeping multiple copies of each data item. In this way, each user connected to the database sees a snapshot of the database at a particular instant in time. Any changes made by a writer will not be seen by other users of the database until the changes have been completed (or, in database terms: until the transaction has been committed.)

[知乎link][acdlink]
> ACD三个特性是通过Redo log（重做日志）和Undo log 实现的。 而隔离性是通过锁来实现的。  
> 重做日志用来实现事务的持久性，即D特性.  
> Undo log (MySQL):  
>   1. 实现事务回滚
>   2. 实现MVCC

[repeatable read vs read committed][repeatableread]  
> 在innodb中(默认repeatable read级别), 事务在begin/start transaction之后的第一条select读操作后, 会创建一个快照(read view), 将当前系统中活跃的其他事务记录记录起来;
> 在innodb中(默认read committed级别), 事务中每条select语句都会创建一个快照(read view);
> 其中INSERT操作在事务提交前只对当前事务可见，因此产生的Undo日志可以在事务提交后直接删除（谁会对刚插入的数据有可见性需求呢！！），而对于UPDATE/DELETE则需要维护多版本信息，在InnoDB里，UPDATE和DELETE操作产生的Undo日志被归成一类，即update_undo
> 在回滚段中的undo logs分为: insert undo log 和 update undo log
>   *   insert undo log : 事务对insert新记录时产生的undolog, 只在事务回滚时需要, 并且在事务提交后就可以立即丢弃。(The new record is stored in the table itself. No need to serve reads from undo log. Undo records for insert only serve for transaction rollback. log only needs to tell when that new record was inserted so that we can determine when to undo it (remove it during rollback).)
>   *   update undo log : 事务对记录进行delete和update操作时产生的undo log, 不仅在事务回滚时需要, 一致性读也需要，所以不能随便删除，只有当数据库所使用的快照中不涉及该日志记录，对应的回滚日志才会被purge线程删除

[acdlink]: https://zhuanlan.zhihu.com/p/48327345
[repeatableread]: https://segmentfault.com/a/1190000012650596