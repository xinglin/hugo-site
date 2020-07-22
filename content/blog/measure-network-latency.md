+++
author = "Xing Lin"
title = "Measure Network Latency"
description = ""
tags = [
    "note",
    "tip",
    "network latency",
    "tech"
]
date = "2020-07-22"
+++

Quite often, we need to know the network round-trip time (RTT) between two nodes
and a fairly well known tool is ping. However, today, I just found it out
I probably used the ping tool in a wrong way all the time. 

By default, ping sends out a packet every second. It can have a huge impact
on the network latency. We can use the -I option, to set the interval.
Below are the RTT values I collected between two servers connected directly with
a cable.

| Interval | Latency (us) |
| :------: |  :-----------: |
| 2s |  |
| default (1s)    |  161       |
| 200 ms     |   132       |
| 20 ms| 130 |
| 2 ms     |    73    |
| flood (-f)| 22 |

Netperf is another tool used for network performance testing as well. 
By default, it sends out a request immediately after the previous one completes.
One can use it to test TCP/UDP round-trip time.  
It is probably the preferred tool to do latency measurement, than ping. 
netperf shows the TCP RTT is 37 us for the same two servers where I used ping to test RTT. 

At one server, start netserver. At the other server, start netperf to do the tests. 

    $netperf -p 12345 -H 172.16.0.25 -l 100 -t TCP_RR -- -o min_latency,mean_latency,max_latency,stddev_latency,transaction_rate

One can download the netperf source code from git. However, 
they have removed the configure file in the source tree. 
To generate the configure file, we can run the autogen.sh script. 
We may also need to install texinfo package, to get the makeinfo tool. 

# Reference
* [Measuring network latency in the cloud][gcp]
[gcp]: https://cloud.google.com/blog/products/networking/using-netperf-and-ping-to-measure-network-latency
