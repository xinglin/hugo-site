+++
author = "Xing Lin"
title = "Key Value Workloads"
description = ""
tags = [
    "keyvalue","workload"
]
date = "2021-03-05"
+++

# YCSB
| Workload | Description | Example | Operation breakdown|
| :------: | :--: | :-----------: | :-----------: |
| A     | Update heavy workload | session store recording recent actions        | read: 50%, update: 50% |
| B     | read mostly workload | photo tagging;  add a tag is an update, but most operations are to read tags        | read: 95%, update: 5%  | 
| C     | read only | user profile cache, where profiles are constructed elsewhere )e.g., Hadoop)        | read: 100% |
| D     | read latest workload | user status updates; people want to read the latest        | read: 95%, insert  5%|
| E  | short ranges |    threaded conversations, where each scan is for the posts in a given thread (assumed to be clustered by thread id)     | scan: 95% (maxscanlength=100), insert: 5|
| F  | read-modify-write workload |  user database, where user records are read and modified by the user or to record user activity.      | read: 50%, readmodifywrite: 50%|
