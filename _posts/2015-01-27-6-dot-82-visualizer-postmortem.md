---
layout: post
title:  "6.82 Visualizer Postmortem"
date:   2015-01-27 01:00:00
description: "A postmortem analysis of building a gold and experience data visualizer for Dota 2's controversial 6.82 update"
media: "682visualizer.mp4"
categories: programming, web-development, dota2, angular, javascript
comments: true
---
<a href="http://jasonjl.me/682Visualizer">Website</a> \
<a href="https://github.com/lee-jason/682Visualizer">Source code</a>

6.82 Visualizer is a gold and experience data visualizer (grapher) for the game Dota 2. There was a controversial update to the game where the game would give the losing team drastic advantages so that they would be able to catch up to the leader. The changes are difficult to imagine due to the amount of variables so this program was created to show the data on how much the game had changed.

For those unfamiliar to the game of Dota, there are two teams of five that duke it out against each other to ultimately destroy their opponents base. Just like a real war, the way for a team to gain an advantage is to have more money, that's essentially what Dota's gold and experience is. Many members in the community were worried that the change to give the poorer team a boost to their economy would change their game for the worse. Many who were vocal about this had personal anecdotes but very few had the hard data. I sought to provide the community with the hard facts in an easy to view format of how the experience and gold were exactly affected so that we could see clearly just how much it altered the game.

## The Backend

Backend? What backend? There actually is no backend to this site. The entire application is self-contained in the html and js file. The page is served through GitHub's project pages much like this blog you're reading.

## The Frontend

The front end was built using a charting library [chart.js](http://www.chartjs.org/) as well as [angular.js](https://angularjs.org/) for the data binding. In the angular file, I have one controller for the form that maintains all the adjustable data. I knew that angular would be a good fit for this project since it very easily binds changeable data to the view. I also created a 'chart' directive attribute tag. This chart directive contains code to initialize whatever element it was inserted into to become a chart. And finally I had one factory that contained all the formulas for calculating the data. I tried using as much as angular offered in intelligently splitting up the tasks of the site.

## The good, the bad

This is actually the first site I made that was incredibly well received. Unlike my other sites, marketing this one was no problem. I posted it once on reddit/r/dota2 where it quickly rose through the ranks with nothing but positive praise. I felt very alive after receiving the first bits of feedback. I quickly continued to work after the initial release creating more graphs, more analysis, preset configurations, sharable configurations, layout changes (you can actually see the [history here](https://github.com/lee-jason/682Visualizer/commits/gh-pages)). I keep realizing that community feedback really drives me forward and motivates me to a degree that I can't find anywhere else. Community figures were tweeting about my site, forums and fan pages in China, Germany and Russia were referring to my page, the page was being shared organically through Twitter and Facebook. It was actually quite amazing for me. I'm really proud of the fact that I was finally first to market in something. Usually most of my ideas are imitations or alterations on an already existing idea, but this time I got lucky.

That's all well and good but of course there's some bad. The bad is that the page is not optimized in a degree that I would be proud of. Granted, the application is very JavaScript heavy in the amount of calculation and redraws required from both the charting library and angular but playing with the sliders produces choppy animation. Optimizing that page to for its redraws to be at 60 frames per second was not my highest priority but it would be a good assignment to bury myself in (later). I'm also a little ashamed that I wasn't able to produce a proper mobile/tablet view. According to Google Analytics, about 10-15% of hits were coming in from tablets which is expected. I anticipated a mobile design view would have taken too much effort for it to be worth it. I could only have imagined a site redesign with unique scripts to support a program with this many charts, knobs, and buttons.

Well there you have it. Although this site might not be useful to you random reader but it definitely should be useful to the Dota 2 enthusiast.