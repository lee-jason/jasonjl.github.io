---
layout: post
title:  "Adventures in Vibe Coding"
date:   2025-09-30 08:00:00
description: "A collection of retros on a bunch of mini projects"
categories: ai, postmortem
---

I paid for a month of Claude Code, leveraging Sonnet 4 to run a bunch of coding experiments. Here's what I found.

# TLDR 
Claude seems to be very good at greenfield development work. Here's the workflow I've been using that I also see others online having success with.
1. Research
2. Plan your approach
3. Execute

This flow usually leads to a fairly predictable initial implementation at least in defining a high level project skeleton.

People who let Claude run amok with excessive command privileges and free reign to update and run anything are careless and reckless. Same for those who run agents of agents. This is a surefire way to not understand anything you co-created which leads to an unmanageable unmaintainable project. Sometimes that trade off is acceptable like if you're building throwaway code. If you expect your code to be maintained in the future, then it is not. Don't be rude to your teammates, use your discretion.

Claude is well worth the twenty dollars a month in terms of developer empowerment. What's more important than the speed of execution is the increased speed of experimentation and learning. Love the tool, don't love how such a powerful tool for learning is paywalled.

# breadnotes
{% include img.html page=page name="breadnotes.png" %}
[Source code](https://github.com/lee-jason/breadnotes)

My first project was to create a simple crud app made to be highly scalable using cloud based orchestration and services. I wanted a place to publish my bread creations and thought to create a picture blog for my bread. In hindsight, the title 'breadblog' is much better than breadnotes, but the implementation and variables were too littered with the word 'breadnotes' to back out of that decision.

Here's what I wanted out of breadnotes.
1. Infra as code
2. Cheap cloud hosting
3. Highly scalable
4. Easy to setup dev environment
5. Easy to deploy

I hashed out these ideas with Claude and went through a glut of options from languages, frameworks, servers, all in one deployment, custom deployment.

My first approach led to something like the following. FastAPI API Server deployed on EC2, Vite front-end deployed bundled and deployed to S3 served by CloudFront, On demand Postgres DB on Aurora, artifacts created in github actions. This was a fully fledged development and deployment environment and a basic product spun up in around a few days. 

I felt very empowered to make large migrations and architecture refactors. Aurora pricing was larger than I initially imagined since I thought I'm only charged for requests. Turns out I'm charged for work units, which there is a minimum amount of work units needed to keep it running. I switched over to a very low speced RDS to see if this would help. It did but was still too high for essentially no requests per minute. I ultimately swapped over to Supabase Postgres which is free, but shuts down after around seven days. All of this infra is managed through terraform.

{% include img.html page=page name="costs.png" width=500 %}

I thought the cost of paying for EC2 for my API server was too expensive so I migrated from a EC2 server to AWS Apprunner since Apprunner is a pay for requests system. I thought I would save a lot of the costs since my site receives like 0 requests per minute, but turns out Apprunner also needs to be kept alive, and is forcibly kept alive with a periodic health check ping to your api server. I accepted and ate the cost on this one.

# personalstorage
{% include img.html page=page name="personalcloud.png" %}

[Source code](https://github.com/lee-jason/personalcloud)

I was running out of Google Drive space and needed to clear out some data because hell if I'm going to pay $24 a year for 100GB of space. I wanted to be able to use AWS frozen storage to put some heavy files in that I rarely touch but would love to have around.

Here's what I wanted out of personalstorage
1. Infra as code
2. Portable, anyone can deploy
3. Can push and retrieve from other machines
4. Easy to use

I had Claude requisition a simple glacier storage s3 bucket that I can sync to and pull from, along with a handful of make commands to make it dead simple. 

Glacier storage needs to restore files before pulling which does take time so pulling files does require ~24 hour turnaround time which makes things less convenient.
The great thing though is that 100GB in cold storage is $1.20 a year. Since I'm storing around ~10GB I expect my bill to be $0.12 a year.

# personalvpn
{% include img.html page=page name="personalvpn.png" %}

[Source code](https://github.com/lee-jason/socksproxy)

With VPN services costing around $60 a year, I wanted to see if I could do it cheaper. The idea was to leverage an EC2 machine as a on the fly VPN server. 

Here's what I wanted out of personalvpn
1. Infra as code
2. Create an on the fly remote proxy
3. Have it be cheaper than consumer offerings
4. Easy to use
5. Deployable on any machine

I first let Claude handle creating all the VPN configuration and containerizing an OpenVPN setup, but the more I discovered the more I realized I was in a little over my head and I didn't expect to invest this much time in learning how VPNs work. I also didn't want to just let Claude take the reigns without me understanding what's happening. I decided to just simply requisition a remote instance that had a auto time to kill. While not a true VPN, I can SSH tunnel to the instance and use it as a SOCKS proxy on my browser. The instance takes a minute to spin up and costs a few pennies for the few minutes I need to cross check travel pricing in a different region.

# protobuf-playground
I was interested in seeing how big companies create interfaces across their service oriented teams. I know Google mainly ensures interfaces through protobufs so I wanted to uncover some questions I had on how it works.

Here's what I wanted out of protobuf-playground
1. One client, One server, client interacts with server through protobuf

That's pretty much it. This was a discovery project to understand how services communicate with each other. What I discovered is that it seems like protobufs give you too much flexibility in how teams manage their built proto files. It seems like the general consensus is for the owner to host the proto files for the client to find and build the proto files to build the modules for their language. It seems like there's no expectation that that the client keeps up to date with the latest server version, but no enforceable way to do so. Servers are expected to make their service backwards compatible. There's many solutions, free and paid, as to where to host the proto files.

I never got this to successfully run and frankly I didn't care to get a running POC since I think I answered my original question about protobufs.

# codebreaker
{% include img.html page=page name="codebreaker.png" %}

[Source code](https://github.com/lee-jason/kube-playground)

This was pretty much an exercise in learning about Kubernetes and Kafka. I wanted to create a toy application that would have a producer publishing events and a variable amount of consumers to consume events. 

Here's what I wanted out of codebreaker
1. Horizontally scaling consumers / producers
2. Managed by Kubernetes
3. Queue progress observable through dashboard
4. Consumers auto scaled

I was initially imagining that the computationally expensive task would be to crack a hashed message generated by a producer, but being able to control how long each of these would take was hard to control so I just settled on just receiving a simple message then sleeping for a controled amount of time. Producers would create messages in variable rates and periodically spike the message queue to keep things interesting for the auto balancer.

Claude handled creating the kubernetes configuration that ran off minikube pretty flawlessly. I took a little bit of time to understand how Kafka is setup such that multiple consumers can consume (multiple partitions on topic) and set the amount of consumers to scale from 1 to 10. 

I would say in terms of a educational POC this was a success. Got to touch a bunch of services I was scared to touch before due to the high complexity cliff.

# Final thoughts
Five mini projects in a month of Claude Code. Its clear to see the bootstrapping capability is monumental. Its incredible that it works so well out of the box without much fuss. I liked whatever pre-set prompt they had on Claude Code to be a combination of informative without being overly wordy. Where before the friction was around learning something new, the barriers to adopting new technology is lowered significantly in that Claude can handle most of the minutia of configuration. I think this will lead to teams making tech decisions not based on the convenience of team familiarity (which today is still an important facet to consider) but more on whether its the right tool for the job.