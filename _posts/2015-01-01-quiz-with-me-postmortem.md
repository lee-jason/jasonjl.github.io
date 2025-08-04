---
layout: post
title:  "Quiz With Me Postmortem"
date:   2015-01-01 08:00:00
description: "Quiz With Me is a community generated trivia site. Each user competes against the people around the world to test themselves with the trivia questions that they submit."
media: "quizwithme.mp4"
categories: angular, javascript, mongo, node, postmortem, project
comments: true
---

<a href="http://quiz.jasonjl.me/">Website</a> \
<a href="https://github.com/lee-jason/QuizWithMe">Source code</a>

Quiz With Me is a community generated trivia site. Each user competes against the people around the world to test themselves with the trivia questions that they submit. Quiz With Me brings the joy of answering and creating trivia questions vs the entire world!

Every player on Quiz With Me are all competing against each other directly in the same trivia game. Each player gets time to answer the same question as everyone else. Once time is up, the polls are tallied and users can compare their choice to those of their peers. Players can play anonymously or sign-up to keep track of their points. Each player can also submit their own multiple choice trivia question with at least four or more potential answers. Each question can also be judged by the community as to whether it is factually correct or just nonsensical BS.

## The Backend

The backend is ran on node.js with the express framework with a mongo+mongoose persistence layer. This is my second project working with node and I wanted to follow REST API guidelines when creating endpoints. You would think I would use socket.io again to create real-time experience but I really wanted to practice working on creating a RESTful API. Its funny, all API creation guides recommend making your server server-side content stateless. The problem here is that I needed to synchronize all users to the server's state, the time remaining on the current question, and the question itself. I think its easy to create a stateless REST endpoints when dealing with normal documents, but when we're creating a game of sorts, its kind of assumed that we're going to be maintaining a state that all clients have to synchronize to right?

## The Frontend

The front end is composed of a single index.html page that contains a bootstrapped themed skeleton and an angular.js app file that fills it all in. The angular.js file has all the routes inside providers that asynchronously contact the server endpoints to get new questions, or handle logins and registrations, or create new questions. There's controllers for the questions segment, a controller for the poll segment, and controller for the header bar. Each of these controllers does what angular does best which is watch for changes to objects inside the controller which automatically update the tags in the front end. The page is also responsive in that the buttons and content will reorganize themselves based off the window size. There's slight display issues regarding the header bar in the mobile view but I'm generally happy with how I finally got to try out this new framework everyone [loves](http://larseidnes.com/2014/11/05/angularjs-the-bad-parts/) [to](https://medium.com/este-js-framework/whats-wrong-with-angular-js-97b0a787f903) [hate](http://www.thoughtworks.com/insights/blog/angularjs-bad-bits).

## The good, the bad

Of course, competing with your friends and strangers across the world would be the most ideal scenario but the problem is the lack of a user base. The site functions well with all the features of account management, question submission, question tribunal, in an acceptable presentation but all of this doesn't really matter unless someone is using it. The design is also very bare. At this point I'm happy that the functionality works as making the front end look polished was never the goal. The site suffers from terrible SEO due to the angular generated front end that dynamically fills in content. I tried to remedy this by adding an 'about' light box describing the site but it doesn't seem to help. I'm still unsure how to organically get hits for web applications like these without actually doing the work of marketing it first. Its making me believe that the new Google SEO algorithm is dependent heavily on public impression and how well it does on social network sites, Twitter, Facebook, Reddit and so on. The goal of this project was to continue working with node web applications and to get my feet wet with angular. With the completion of this site, I feel like I graduated from the kiddy pool and ended up in the deep-end.