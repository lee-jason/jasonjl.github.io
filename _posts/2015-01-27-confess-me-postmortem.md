---
layout: post
title:  "Confess.me Postmortem"
date:   2015-01-27 08:00:00
description: "Confess.me is an anonymous real-time secret posting website. Other supportive members can send comforting messages of support to the anonymous secret sharer."
media: "confessme.mp4"
categories: javascript, mongo, node, socket.io, postmortem, project
comments: true
---

Confess.me is an anonymous real-time secret posting website. Other supportive members can send comforting messages of support to the anonymous secret sharer. The secret sharer can thank these anonymous eyes and ears for their support in turn. All of this is done in real time letting users have an outlet for those things that they hide to themselves.

## The Backend

This site was made with node with express with the addition of the socket.io plugin for websockets. One of the tricky things to manage was sessions. Websockets aren't actually remembered within the same session so it was necessary to create a session to websocket object storage in the server memory. This ensures that users maintain the same websocket identity as long as they keep the same session identity. After that it was smooth sailing. The socket.io documentation is very basic but explains all there is to know about real-time communication. Set the server up to listen for events, have the client send those events. Have the client listen for events, make the server send those events. Its very basic but I can imagine so much more could be done with sockets ranging from real-time games, polls, data, and even parallel computing.

In terms of persistence, there wasn't supposed to be any message persistence. Lacking message persistence gives each message a fleeting property as if your secret will be seen but soon let go and forgotten. This was the initial plan, but since there is a severe lack of a userbase many new users would be confused and see nothing on the homepage. I felt the need to store some of the latest messages so that new visitors will see that there's actually some content. I use the hip new document storage system mongo wrapped with the mongoose framework. The mongoose framework includes the ability to create object schemas for the mongo database. Even though mongo is naturally a schemaless storage system, I feel like it gives too much freedom for the user which would ultimately result in errors and confusion. Mongo as itself is a pretty simple concept to understand for people already familiar with JavaScript objects. My only wish is that it would carry some familiar SQL syntax for table searching but unfortunately its a new syntax, still simple, but new. Mongoose required a bit more reading to understand though. Its documentation is decent but [I never really liked frameworks](http://jasonjl.me/blog/2014/10/17/framework-frustration/).

## The Frontend

The front end is pretty simple, uses the client side javascript for socket.io and some extra javascript to accomodate the multi-column layout. The front end is media query responsive so it'll shrink itself to as many or little columns needed on smaller devices. It was fun trying to get the messages to organize themselves based on a multi-column layout vs a single column mobile layout. My rule for the multi-column layout was to always places the message in the smallest column as well as have newer messages up top, that way all column heights would be relatively even. When users resize their window, messages get reorganized so that it always follows this rule. I also used google's third party library on html sanitization to prevent the page from accepting links and to protect users against XSS attacks. The problem with this real time updating of content is that the site has zero SEO. All content is dynamically injected through javascript so there is no content to scrape on the index.html page. To be fair though, I didn't really optimize the page to be picked up by search engines, otherwise I would have included an about page, or help, or a blog, or something with actual content, or server side rendering, but at this moment I'm just happy that its primary function works, even when there's no audience.

I've always been fascinated with real time communication and what that could mean for the web. I thought for this project having someone respond with immediate results would be better than having to refresh the page constantly to see if someone replied to your secret.

## The good, the bad

The good part about the site is that it works. The bad part about the site is that it has no user base so it can't really function as intended. Ideally there will always be more than a single person on, but at this point it has no user base other than my multiple testing browser windows. At this point I'm not sure if it can even handle more than five people at a time much less a hundred or even a thousand. Currently the code is sitting on a free Heroku dyno, I never intend on taking it to a real production level plan unless it happens to explode with popularity which I doubt. This was also my first experience in javascript server side programming. It was interesting imagining how code jumps around to different functions in a non-sequential manner and to be honest, I'm still not entirely sure how to handle errors. I haven't yet fallen into callback hell but I can imagine that it can get pretty nasty in larger applications.

Well there you have it. I hope this site will be useful as an outlet for the things that trouble you.