---
layout: post
title:  "Bejeweled Bot"
date:   2014-11-24 08:00:00
description: "Bejeweled Bot is a bot that automatically plays Bejeweled Blitz as fast as possible. Once executed, the bot will orient itself with the origin of the game board, determine the current gems on the grid, parse the possible matches, then move the appropriate gems in the game to create matches."
media: "bejeweledbot.mp4"
categories: bots, java, postmortem, project
comments: true
---

<a href="https://github.com/lee-jason/BejeweledBot">Source code</a>
<a href="https://apps.facebook.com/bejeweledblitz/?fb_source=search&ref=br_tf">Source game</a>

Bejeweled Bot is a bot that automatically plays Bejeweled Blitz as fast as possible. Once executed, the bot will orient itself with the origin of the game board, determine the current gems on the grid, parse the possible matches, then move the appropriate gems in the game to create matches. I forked the repository from [kklemm91](https://github.com/kklemm91/BejeweledBot) and improved on code organization, naming, and execution efficiency.

## Execution

Upon initial execution, the bot looks for two identifying pixels indicating the upper left origin of the bejeweled grid. Once found we can then determine the location of all the jewels on the grid. Each jewel is a set pixel width and height apart from each other which makes it easy to sequentially check each pixel color that's at the center of each jewel. Each jewel color is given an identifying enumerable int and placed into a 2d int array. This array is then parsed index by index to find any potential matches. If a match is found, the program immediately takes action and matches the jewels in the game and then continues looking for more matches.

While gaining a score of 500,000 is considered to be the most impressive feat, the bejeweled bot regularly is able to score greater than a million consistently without assistance.

## Issues

Unfortunately, there are moments where the program may stall or softlock. Bejeweled doesn't use any fancy dynamic filters meaning that checking the same pixel location of the same type of jewel will produce the same result every time. The only exclusion to this rule would be when the jewel is dynamic such as the lightning jewel or the hypercube which is animated to spin producing inconsistent results. These inconsistent results mean that the matcher may miss these matches due to the pixel not being caught and parsed. Multiplier jewels are consistent but not all of them have been documented due to the tedious nature of the work. This means that matches involving multiplier jewels may be missed due to the program not knowing that the multiplier pixel is that of a matching color. This is easily fixable but tedious due to having to play enough bejeweled matches to find the randomized multiplier jewel color. This means that the bot does have tendencies where it stalls due to not being able to detect a match on the board, requiring human intervention so that it can move forward. This form of pixel detection is also dependent on PopCap not changing the art of the game, otherwise the bot will no longer be able to determine the matches.

Instances where the game freezes may also softlock the computer's mouse due to the game attempting to match a jewel indefinitely. Exercise caution if executing this on a slow machine.

## Improvements

While [kklemm91's](https://github.com/kklemm91/BejeweledBot) initial program was a good start I wanted to see if I could make it better. When executed, the initial base program would make all the matches visible in the screen, then wait roughly half a second before making the next set of matches. This was good but I wanted the bot to be inhumanly fast.

In this base program, there was a line that would make the current thread sleep for around a quarter of a second. I noticed that modifying this to be shorter or removing it entirely didn't make the matches happen any faster. I was wondering what the hold up was in the program so I created a rudimentary profiler where I would log out start and end timings into each important method (I'm pretty sure there's better ways to profile Java methods). I noticed that most methods ran almost instantaneously but the problem method that was running slowly was the match finder. It wasn't the act of finding matches that was slow itself, but the fact that it was recapturing a snapshot of the board for each pixel that it checks. This is completely unnecessary and the program was changed to take an initial snapshot, determine all pixel colors from this snapshot, then find matches, based off that board, repeat. This act was like removing the handicap from an olympic sprinter in a children's fun run. The bot went zooming and was matching at an insane pace.

Another improvement involved the search for the origin point of the board. There was an issue where the program would inconsistently determine the correct origin point. Sometimes it would find it correctly, other times it would offset the origin a few columns to the right, skewing the vision of the bot. Initially the bot determined the location of the origin of the board by detecting whether the pixel was one of the jewel colors. Once found, it then checked to see if several of its neighbors were also has jewel pixel colors. This for some reason produced inconsistent results in determining the origin of the game board and to be honest its absolutely confusing as to why it would do this. I was unable to find the root of the problem so I created a new origin determining method that checks for a sequence of pixels. It's the same concept as the original implementation but when it's based off the color of the gems itself, it appears to produce inconsistent results.

An improvement in color matching that would remove our dependency on PopCap not changing its colors would be to use average color detection. Instead of identifying colors based off pixels, we could use an average of the color that falls within the bounds of a block in a grid. This means that the colors don't have to be pixel perfect so if PopCap decides one day to update the art but keep the same color of the jewels, it'll most likely continue to keep working. This improvement seems a bit overkill though and is not necessary at the time due to the nature of the project. If I had a bigger budget though I'd gladly like to implement a basic color detector. I'd imagine the performance would take a hit but it would be interesting to see the program dynamically decide similar looking colors.

Well there you have it. Thanks to [kklemm91](https://github.com/kklemm91) for showing me the awesome Java Robot class and building out the base of the program.