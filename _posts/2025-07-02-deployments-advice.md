---
layout: post
title:  "Releasing at the speed of code"
date:   2025-07-02 08:00:00
description: "Why we shouldn't sleep on our deployment process"
categories: advice
---

Something I value more recently is easily deployable software. Most engineers are probably more interested in building robust and easily maintainable code but may be divorced from the idea of deploying their code as those systems or processes may already be set in their organization. Easily deployable code means its much easier to take risks and create experiments which relieves paralysis in deciding when or how some bit of change should be released. If your company is still arguing about when to time a release or meeting some specific release window, you may want to evaluate whether your current release process is holding you back.

## Deployments should be a zero clicks
Any non trivial deployment needs to be automated. Manual processes are fine, but ultimately lead to more wasted time amortized across all deployments which is a friction point around deployment. Time spent to automate the process further reduces friction around deployment leading to faster release cycles, less planning conversations, and more free cycles for everyone involved in the conversation.

## Failures should be accounted for
Process driven deployments are tricky and are inherently stateful. A deployment can fail in any number of steps and at any point in the flow. The automated process should anticipate these. Deployments should catch and handle common breaking scenarios and rollback appropriately. This doesn't mean that the system should be able to support rolling back to any arbitrary version, but this really just means that if any part of the step is failing, stop at that specific step and reset that step to before the change. In the case of a simple data migration, this can mean running the migration in a transaction, or in the case of a front-end code deployment a matter of having a system to deploy the previous front-end version, then auto triggering that on when new front-end failures are detected.

## "F--- it, we'll do it live!"
Common knowledge tells us that testing before deploying is a pillar of software development, I'd like to suggest and warn that some teams may be testing too much or relying too much on manual testing. The only valid reasons to have a prolonged testing cycle is when...
1. Your software has safety implications where failure costs lives
2. Its difficult to deploy/rollback your software.

In a modern web based software engineering product we can assume that...
1. Your software does not have safety implications (consider authorization)
2. Its easy to deploy/rollback your software

If the above are true, then why use even more precious time testing? Deploy and rollback quickly. Or Deploy and iterate quickly.

The suggestion is clearly provocative and there's obviously more nuance to the idea, but I'm not suggesting you to abandon your internal test cycle and have your customers be your guinea pigs. I'm suggesting that there may be opportunities to cut your test cycles shorter if you are confident in being able to deploy/rollback quickly. Shorter internal test times, may mean more time spent bug fixing or working on the next release.

I've been on a big 'reduce friction' kick, and from my previous companies, I see the deployment problem being a huge friction point to getting code to customers. I think this is a critical area in software development that should not be overlooked and should be given a second look to see how close we can get to a zero click deployment.