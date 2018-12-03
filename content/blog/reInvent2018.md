+++
author = "Xing Lin"
title = "AWS ReInvent 2018"
description = ""
tags = [
    "conference",
]
date = "2018-12-03"
+++

I attended the AWS ReInvent at Las Vegas the week after Thanksgiving. It was a great week there, learning AWS technologies while also having fun. The keynotes given by AWS CEO and CTO were always exciting: they covered important new services that were launched during this event. Other sessions shared best practices in using AWS services and infrastructure. They also had music bands playing live music at the site and provided great lunches and snacks during the morning and afternoon breaks. Besides, we can come and pick up a swag every day. This year, more than 50,000 people attended the conference and you can see lots of people walking around. This is by far the largest conference I have ever attended and I was amazed by how well they managed to organize it. 

* Computing services
** Support for ARM processors: A1 instances. Good for scale-out application and bring cost saving (~45%)
** V100 GPUs: P3 instances with 8 NVIDIA Tesla V100 GPUs. 
** Elastic graphic / Elastic Inference: add GPU on-demand to normal EC2 instances, only for graphic or inference tasks 
** 100 Gpbs NIC: c5n instances

* S3 storage: 
** Intelligent tiering: automatically migrate objects from S3 standard to S3 infrequent access, to save customer S3 storage cost
** Glacier deep archive: a tape replacement solution. Even cheaper than Glacier. 

* AWS DataSync Service: migrate data between on-premise NFS server and S3/EFS. Need to deply a VM at on-premise datacenter to run the DataSync agent. Mentioned use of compression and multi-part PUTs to improve the transfer performance. Audiences also asked the support of Object store/SMB/HDFS as another source.  


* New Database services
** AWS Quantum Ledger Database (QLDB): to store immutable, and cryptographically verifiable transaction logs where there is a central trusted authority.  
** AWS Timestream: time series database

* AWS Lambda:
** IDEs: AWS Toolkits for Visual Studio Code, IntelliJ, and PyCharm
** Supports custom runtime for any Linux compatible language runtime
** Supports Ruby, C++, and Rust 
** Supports for Php, cobol, Erlang, and elixir are available from AWS partners
** Lambda layers: allow multiple lambda functions to share libraries
** AWS serverless application repository: store, share, and deploy serverless applications
** Step function service integration: from a step function, one can now talk to Lambda, Batch, DynamoDB, ECS/Fargate, SNS, SQS, Glue, and SageMaker. 
** Application load balancer (ALB) support for Lambda: one can trigger lambda functions directly from ALB. 
** Firecracker: AWS's lightweight virtualization technology based on KVM. It is the underling container technology powering AWS Lambda and AWS Fargate. Each VM takes only 5 MB of memory. They claimed to achieve startup time as short as 125 ms and can provision 150 microVMs per min/host. They make it open source.


* AWS Managed Blockchain
* AWS Managed Kafka
* AWS forcast: time series forecasting
* AWS personalize: real-time personalization and recommendation
* AWS outposts: AWS hardware installed at on-premise datacenters; running AWS software; consistent management/use experience


* Machine Learning
Three layers of AI software stack (from top to bottom)
** AI Services: TextToSpeed, etc
** ML Services: Sagemaker
** ML frameworks: TensorFlow, MXNet, and pyTorch

** SageMake Groundtruth: provides auto labelling or human to add tags to datasets; For auto labelling, one can set the confidence level: it will only set labels when the confidence from the algorithm is higher than the threshold. human label: mechanical trunk; third party; or your friends. 
** AWS Marketplace for machine learning: a place to pick up/sell machine learning packages.
** SageMake Reforcement Learning: provides RL models.
** SageMaker Neo: open-source compiler to compile a machine model for different architectures (TPU/GPU/Intel CPU/ARM, etc.)



