---
layout: post
title:  "Share Codes Postmortem"
date:   2015-01-15 08:00:00
description: "Share Codes is a site for people to trade beta/alpha/early access codes. The premise is simple, people with codes post their email and people who want codes post their emails."
media: "sharecodes.mp4"
categories: angular, javascript, mongo, node, postmortem, project 
comments: true
---

<a href="http://sharecodes.jasonjl.me/">Website</a> \
<a href="https://github.com/lee-jason/ShareCodes">Source code</a>

Share Codes is a site for people to trade beta/alpha/early access codes. The premise is simple, people with codes post their email and people who want codes post their emails. Match made in heaven!

This site was originally created for people to share the early access demo code for the video game Super Smash Brothers for 3DS. Only a few privileged people were able to receive an early access code from Nintendo and had a few codes to share. Internet communities across the web were going wild on searching for a spare code while those fortunate ones with the codes had the opportunity to get something in return for having such a rare commodity. I felt a site like this was needed to help people filter all the noise into something more digestible. The site was furiously written and released and it even helped some people find and give away codes.

## The Backend

The backend was made with node with the express framework. Once again I tried to make a proper REST API style endpoints that my front end would connect to. All emails are stored in mongodb through mongoose. The server has a scheduled timed function that prunes emails from the email list if the email is older than 30 minutes. That's it, there's nothing more interesting to say about the backend.

## The Frontend

The front end was created with plain old html with the bootstrap framework for styling. I don't really like using the bootstrap grid layout feature so I don't use that and make my own responsive layout using flexible containers and media queries. The form posting of the emails is not actually asynchronous. I know the experience would have probably been better if emails asynchronously updated without a page refresh but I haven't worked on a non-asynchronous site in so long that I really wanted to remind myself how to do it using traditional forms, actions, and methods. Its funny, I'm a developer born into the web 2.0 world that I have little project experience on how to do things in the web 1.0 world. I also wanted users to keep refreshing their pages to simulate heavy load to test how much strain a single Heroku dyno can take.

## The good, the bad

The micro app was a blast to make. I knew that there was a time limit of relevancy since the codes would expire in a week. I churned this site out in around six hours just to see if I could. I think I felt that this would be kind of a proving ground whether I'm comfortable enough with node to create a basic web application relatively quickly. Fortunately I was able to reuse the framework from my other node projects that already had the configurations I wanted. The site worked and I felt really alive after I saw actual users on the site. I continued to make small improvements to the layout, adding extra fields, cleaning up text, making it responsive, all within the first hour of being live. If I wanted to generalize this, I can just swap out the title and make it apply for any kind of pre-access code sharing site.

So here's the bad. The bad involved the marketing. Once I was done, I sent it around to my friends, then I made a post on Reddit in the primary thread and any other thread involved in trading of codes. Unfortunately for me, these threads were already filled to the brim with people looking for codes. It was a storm of fish desperately trying to gobble the bait. I think it was the largest Reddit thread I've seen at 20,000 comments since I last seen it. Every time I would make a post in a thread I would check the analytics and I was fortunate to even get a few bites. Someone even posted it on their Facebook wall thereby getting a few more bites. It was pretty swell, my site was actually being used by real people. Many of them posted their email looking for codes but nobody posted their email giving away their code. It was a seller's market at a rate of 1 seller to 50 buyers. Some users kept reposting their email when it got pruned but then eventually the site would be empty.

Well, there you have it. I'm glad that some people were helped by the site, but it didn't spread even when I hopped around forums posting the link. I think the clarity of the share codes service is actually really helpful but when people are already ingrained in their communities it seems that they can't be bothered to use anything else.