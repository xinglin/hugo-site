+++
author = "Xing Lin"
title = "Idea Repository"
description = ""
tags = [
    "ideas",
]
date = "2021-02-22"
+++

List of ideas to explore.

* Interaction between a filesystem and a computational SSD that does transparent compression. 
    * Problem: How to manage SSD space in this case? What API should be use?
    * Can use SSDSim to explore the design space.

* Key prefix compression in k/v store
    * Problem: in levelDB, it uses fixed-size key prefix compression. Can we do better than this? 
    * In Rockset/Foundationdb, secondary indexes are stored as <key, null> key/value pairs. This creates an opportunity that significant storage saving can be achieved if we can do a better key compression.

* [Zoned namespace SSDs][zonedns]

[zonedns]: http://zonedstorage.io/introduction/