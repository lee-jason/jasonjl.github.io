---
layout: post
title:  "Blog migration postortem"
date:   2025-07-16 08:00:00
description: "Highlights on the critical need for a fast deployment process"
categories: project, postmortem
---

In 2015 I spun up a personal blog after I quit my first job. This was built off [Octopress](https://octopress.org/) and deployed on Github pages. Despite the compiled site existing on Github itself [lee-jason.github.io](https://github.com/lee-jason/lee-jason.github.io), the source itself existing on a laptop that is long gone. 

2025 I'm still alive and I'm once again in a similar situation. I suddenly found myself with more time and with that time wanted to write, unfortunately I didn't have the source code for my blog. I decided the only way forward is to migrate from compiled Jekyll to Jekyll 4.0.

Ten years have passed and Jekyll is now on version 4.0. As a chronic hackernews reader I stumble on a lot of blogs. I really liked the simplicity of [https://florian.github.io/](https://florian.github.io/). I forked his [repo](https://github.com/florian/florian.github.io) and built off that. Some minor changes later, I had working POC that ran on Jekyll 4. 

I thought for a minute on using an existing blogging platform like medium or notion, but one of my philosophies is to build as cheaply as possible and hosted blog platform often offer you all the bells and whistles of analytics and custom domains but often do so with a fee. I was unwilling to do so.

I now needed to configure deployment. Josh Larsen had a great [Github Action](https://github.com/joshlarsen/jekyll4-deploy-gh-pages) script to deploy custom Jekyll builds and deploy the compiled code to the `gh-pages` branch. I forked that and added the option to have multiple Jekyll configs be passed in the build step. This allowed me to have a production specific config to load resources pointing in the right production area. This makes deployments easy in that you only have to push a change to 

I noticed my media assets were also all sitting in a single bucket. I re-organized this to follow Jekyll's recommendation where media assets are namespaced by their specific blog's slug. There's also a simple sync-to-s3 command that makes it easy to sync new resources in the assets folder. I then added Cloudfront caching in front of the media assets, but then wondered what the point was when the hits to my blog are so few and far in between it would probably take longer to load the cached content in each leaf node.

And finally, the data migration itself, parsing the compiled content and generating clean markdown from it. This is a little bit manaual but in the age of LLM AI anything is possible. I pretty much just ask Claude page by page to convert the contents into Markdown. It does a stellar job but has trouble reading the embedded code sections which I'm not sure why. 

# Improvements

The tagging feature is gone! Although Jekyll supports indexing posts by tags, this theme from Florian does not support it yet. I'll need to reimplement this but I don't think many people use it so I'm not too pressured to implement it any time soon.

# Learnings

After realizing that my past-self did present-self a disservice by leaving only the compiled content, I promised future-self that I would never do him that dirty again. From here on out, I promise to write great documentation and simplify processes such that future-self in 2035 can easily pick up this repo on his M10 chip Macbook Pro++ and deploy a new blog article in minutes.