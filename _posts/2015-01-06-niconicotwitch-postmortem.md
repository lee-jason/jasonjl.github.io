---
layout: post
title:  "NicoNicoTwitch Postmortem"
date:   2015-01-26 08:00:00
description: "NicoNicoTwitch is a JavaScript canvas project that's meant to bring over the unique on-screen scrolling commentary feature of Nico Nico Douga onto the popular game live streaming platform twitch.tv."
media: "niconicotwitch.mp4"
categories: javascript, canvas, twitch, jquery, postmortem, project
comments: true
---

# NicoNicoTwitch Postmortem

NicoNicoTwitch is a JavaScript canvas project that's meant to bring over the unique on-screen scrolling commentary feature of [Nico Nico Douga](http://niconico.jp) onto the popular game live streaming platform [twitch.tv](http://twitch.tv).

I made this because I always loved Nico's unique text-on-video overlay of community comments and wanted to bring that over to Twitch who also sports a vibrant community. I personally think that bringing the chat closer to the video gives us a closer connection to those on the people on the web as you can relate when you both find a certain scene uproariously hilarious, or another particular scene sad. Twitch was the perfect video playing platform to emulate this feature on due to the chat being in real-time as well as being quite infectious with its commentary.

The basic rundown of how NicoNicoTwitch works is pretty straightforward. Set a timer to read any updates in the chat, when there's new messages, parse and process them for any emoticons, send them to the display sorter where it'll find a spot for them to 'marquee', then update and animate the text. The jQuery library was used for its convenience in dom selection and traversal through all the chat elements and the HTML5 canvas feature was used to paint the text over the video. The following will go into a bit further detail about the intricacies of the program.

## Running it

So how do you run it? Well, at this point there is no proper executable. Its simply a hack that's supposed to be ran through the browser JavaScript console. Just go to a twitch streamer page with chat (i.e. not the homepage) open the console (f12) and paste the code in. I'm not exactly sure how to package this up if I want to release it publically. I hear Chrome Apps is pretty easy to use in terms of packaging up JavaScript applications but to be honest, sharing this wasn't my priority, it was mainly done for the practice.

## The Nitty Gritty

So what happens when you paste the code in your console? First, I use jQuery to identify where the video flash element is on the screen and overlay a new Canvas element directly over it. This canvas element is transparent and will be used for our flying text. I insert the 'Initialized' text message into the message processing queue where the message is then processed and inserted into a TextObject where it is given its current x and y coordinates as well as the width of the message, the speed at which it'll be flying across the screen, the color of its user, and of course the text message itself.

## Inserting the Text

The `insertText` function decides the initial location of the text on the screen. New messages captured from the dom get passed into this function. I gave two rules to deciding the text location.

1. new text shall be placed as close to the top as possible
2. text should never overlap each other.

Ensuring that text wouldn't overlap each other essentially required that any incoming message wouldn't start to leave before the already outgoing message left the screen. This required a bit of math involving the velocity of text, the frame rate, the canvas width, the width of the text itself, and the width of any emoticons inside it. I was very fortunate that canvas already supplies a method that measures the width of any supplied text with `context.measureText("text")`. This took out the grunt work of measuring each pixel width of each letter individually and calculating the width of text messages letter by letter. I was unsure of whether my `insertText` function was going to work until I implemented my animator.

## Updating the Screen

My animate function is pretty straight forward. Clear the canvas screen, update the location of each active text objects based on their given velocity, draw the text back on the screen. When all is over, it calls a global function `requestAnimFrame` that calculates when to call the animate function again. Currently the Frames Per Second (FPS) is set at 30, so each animation frame triggers every 33.3ms. The FPS is completely adjustable through a variable but I think it looks best at 30. If I didn't time the animation frames to run in a constant manner, text would probably speed by unnaturally fast as the program would be running the animate function as fast as it could.

## Parsing the DOM + Messages

Okay! We got our animate and we have our insertText function, now we just need to read the messages from the chat box. There's another timer that triggers every second to read messages from the chat box. It only reads up to the latest message that it hasn't seen before and sends it to the `insertText` function. This is entirely done with jQuery doing the searching in the DOM tree. What was probably the most challenging here was parsing the html to grab only the information I wanted with regular expressions. I'm not particular with regular expressions but it was good to practice my matching abilities. What was most surprising to me though was that JavaScript's `RegExp.prototype.exec()` only returns the first match. If there are multiple matches in the text for the same regular expression, you need to keep going in a while loop until the exec() returns a null. Why was it designed this way? I think that's very counter intuitive. The reason why I needed to exec multiple times on the same string was to catch multiple uses of emoticons in the same message which as we know Twitch chat loves spamming which makes this a very valid use case.

## Parsing the Emoticons

Of course getting emoticons to appear on the canvas object was not as easy as I thought. I needed to parse out the emoticon html, identify the graphic url, identify the graphic keyword, and have the animate function insert a picture in between the text messages. Before the recent update, Twitch used to display their emoticons using `<span>` tags that had background-images in CSS. Since Twitch has an ever updating emoticon list, I had to preload all possible emoticons and identify each emoticon's url by going through each loaded span and identifying its background-image. Of course this wasn't really that great due to having to pre-load more than 10,000 emoticons before running the program. With the recent emoticon update (which according to the blog updated 4 days ago) Twitch made it way easier to identify the url for each emoticon since they now use an actual `<img>` tag that has the src right inside it. Now I use a system that lazily loads the needed emoticon as soon as someone uses it in chat.

## The Annoyances

Of course with such a successful project there are always some things I'd like to improve on. It can always be more polished obviously but I'm happy at the point that it's at now. I can put further filters in text parsing to remove anchor tags. I can create an actual emoticon object that keeps track of each unique emoticon's width since as of now I give each emoticon around 40 pixels of space. I can refactor the code just sitting out in the open in the NicoNicoTwitch function into its respective config, init, or manager classes instead of barfing everything in the same js file (of course this was before I knew about require.js). I can also clean up comments. As of writing this :) and <3 are not processed correctly by the emoticon parsing system. I also think there's a better way to read new messages from the chat box than to check it every second.

But with all these annoyances that are actually under my control, the one true annoyance is with Twitch itself. It's not that I can blame them, but every time they update their system to use a different identifier, different dom structure, different emoticon keyword, different emoticon url, my program breaks. The fact that my program is completely dependent on them not changing anything to their site is the greatest annoyance. Of course, this was before I knew about their public API that exposes each channel's chat. Regardless, I really can't complain since it is expected that Twitch works on their site to make it better.

Well that was a long boring read but actually watching it come together is something like magic. Its fun seeing two messages on the same line coming close to colliding but actually just barely miss each other. It's also fun when there's a lot of chatters filling up the entire screen cheering with excitement or sharing sympathy with a solitary BibleThump.