+++
author = "Xing Lin"
title = "SPDK on Intel Optane and Samsung ZSSD"
description = ""
tags = [
    "SPDK",
]
date = "2018-05-10"
+++

Today, I started to play with Intel SPDK with a 250GB Samsung 960 EVO NVMe SSD. 
I was thinking that using SPDK might lead to better performance, than through traditional block device interface. 
However, using fio with 4KiB random read requests at the queue depth equal to 1, as it turned out, the difference is rather small.

# Optane # 
| Metric | SPDK    | /dev/nvme1n1 |
|--------|---------|-------------|
| IOPS   | 150 K  | 66.1 K      |
| slat   | 0.13 usec | 2.8 usec |
| clat   | 6.2 usec| 11.4 usec|
| lat    | 6.35 usec| 14.32 usec|

slat, clat and lat are average submission latency, submission to IO completion latency and total IO latency. 

    xing@atg-s-holder:~/w/spdk/examples/nvme/fio_plugin$ sudo LD_PRELOAD=/home/xing/w/spdk/examples/nvme/fio_plugin/fio_plugin /home/xing/w/fio/fio /home/xing/w/spdk/examples/nvme/fio_plugin/example_config.fio
    test: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=spdk, iodepth=1
    fio-3.3
    Starting 1 thread
    Starting SPDK v18.07-pre / DPDK 18.02.0 initialization...
    [ DPDK EAL parameters: fio -c 0x1 -m 512 --file-prefix=spdk_pid25303 ]
    EAL: Detected 32 lcore(s)
    EAL: Multi-process socket /var/run/.spdk_pid25303_unix
    EAL: Probing VFIO support...
    EAL: PCI device 0000:81:00.0 on NUMA socket 1
    EAL:   probe driver: 8086:2701 spdk_nvme
    Jobs: 1 (f=1): [r(1)][100.0%][r=587MiB/s,w=0KiB/s][r=150k,w=0 IOPS][eta 00m:00s]
    test: (groupid=0, jobs=1): err= 0: pid=25339: Thu May 10 21:47:08 2018
        read: IOPS=150k, BW=587MiB/s (615MB/s)(68.8GiB/120000msec)
        slat (nsec): min=121, max=515336, avg=130.59, stdev=126.80
        clat (nsec): min=137, max=821212, avg=6217.80, stdev=1214.79
        lat (usec): min=5, max=821, avg= 6.35, stdev= 1.22
        clat percentiles (nsec):
             |  1.00th=[ 5984],  5.00th=[ 6048], 10.00th=[ 6048], 20.00th=[ 6048],
             | 30.00th=[ 6048], 40.00th=[ 6112], 50.00th=[ 6112], 60.00th=[ 6112],
             | 70.00th=[ 6176], 80.00th=[ 6176], 90.00th=[ 6240], 95.00th=[ 6304],
             | 99.00th=[ 7392], 99.50th=[14784], 99.90th=[30592], 99.95th=[33024],
             | 99.99th=[35072]
        bw (  KiB/s): min=597485, max=602936, per=99.99%, avg=600786.28, stdev=973.76, samples=239
        iops        : min=149373, max=150734, avg=150196.54, stdev=243.53, samples=239
        lat (nsec)   : 250=0.01%, 500=0.01%
        lat (usec)   : 2=0.01%, 4=0.01%, 10=99.29%, 20=0.57%, 50=0.14%
        lat (usec)   : 100=0.01%, 250=0.01%, 1000=0.01%
        cpu          : usr=100.01%, sys=0.07%, ctx=11458, majf=0, minf=3110
        IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
        submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
        complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
        issued rwt: total=18026026,0,0, short=0,0,0, dropped=0,0,0
        latency   : target=0, window=0, percentile=100.00%, depth=1

        Run status group 0 (all jobs):
        READ: bw=587MiB/s (615MB/s), 587MiB/s-587MiB/s (615MB/s-615MB/s), io=68.8GiB (73.8GB), run=120000-120000msec

## Tips
*  Dependencies to install, in order to compile SPDK in debian 8  
        ``sudo apt-get install libnuma-dev uuid-dev libaio-dev libcunit1-dev``  
