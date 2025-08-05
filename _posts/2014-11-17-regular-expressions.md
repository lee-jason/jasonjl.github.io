---
layout: post
title:  "Regular Expressions"
date:   2014-11-17 08:00:00
description: "Regular expressions are hard. There's a lot to them that vary between different regular expression engines. They're often considered to be an afterthought when it comes to a programmer's tools due to the relative infrequency at which they're used."
media: "regularexpression_crossword.png"
categories: regex, programming, javascript, tutorial, parsing
comments: true
---

Regular expressions are hard. There's a lot to them that vary between different regular expression engines. They're often considered to be an afterthought when it comes to a programmer's tools due to the relative infrequency at which they're used. Whenever they are actually needed, the programmer most likely only reads the minimum amount required that will fulfill the parsing problem at hand. Regular expressions are super cryptic to read and even more so when writing them in Java. While I don't necessarily enjoy working with regular expressions, I highly respect those who are comfortable enough to take on any sort of parsing problem. This post is an attempt for me to solidify some of the basic and advanced things I've been picking up with regular expressions recently.

## Greedy will grab more, lazy will grab less

When people keep mentioning use greedy vs lazy quantifiers they're talking about the `?` `+` `*` symbols. The default quantifiers will use greedy matching, meaning, they will try to match as many of the quantified character before it continues trying to find matches with the rest of the expression. Appending a `?` to any quantifier will cause the regular expression engine to become 'lazy' and only match the as little as possible before it finds a complete match. While having a lazy engine may sound like a bad thing sometimes you just don't want your engine working so hard and going overboard with its matches. Say you're making a chat client and you want to intercept colon delimited messages so that you can eventually replace those with emoticons.

<figure markdown="1">
  <figcaption>capturing delimited messages </figcaption>

  ```javascript
      var msg = "hello world :smile: :happy:";
      //greedily match any group of characters between two colons
      var emoteRegExpGreedy = /:.*:/g;
      msg.match(emoteRegExpGreedy); //returns [":smile: :happy:"]

      //lazily match any group of characters between two colons
      var emoteRegExpLazy = /:.*?:/g;
      msg.match(emoteRegExpLazy); //returns [":smile:", ":happy:"]
  ```
</figure>

note how the greedy regexp returns a single value consisting of both the :smile: and :happy: combined into a single match, while the lazy regexp properly returns two values splitting up the smile and happy. The greedy `.` character matcher kept going until the final `:` was found at the end of the string, while the lazy `.?` character matcher was content with ending the first match and the first sight of the `:` after "smile" and started a new match when it found the first `:` for "happy".

## Using matched content in replaces with groupings

This is something that so easy but not entirely apparent when initially learning about regular expressions (at least not for me). Surrounding an expression with parenthesis will create a grouping. Groupings are designated in the order that they are written in the expression. Groupings can be designated with `( )`. A complicated pattern can be written at the start of the expression and reused as a grouping reference later in the expression. Lets say that we want to catch whenever a user writes duplicate words in the chat box because we're nice and we want to catch users making silly mistakes.

<figure markdown="1">
  <figcaption>catching duplicate words</figcaption>

```javascript
    var msg = "hello hello, how are doing doing? I'm feeling good good";
    //greedily match a full word followed by one or many whitespaces followed by the same exact word.
    var doubleWordRegExp = /(\b\w+)\s+\1/g;
    msg.match(doubleWordRegExp); //returns ["hello hello", "doing doing", "good good"]
```
</figure>

Text that's captured in a grouping can also be spit out to be used in the replacement string. So continuing with our chat emoticon example, lets say that you want to replace the matched `:` delimited text with an image tag that points to the appropriate file for each emoticon.

<figure markdown="1">
  <figcaption>replacing groupings with captured text </figcaption>

```javascript
    var msg = "hello world :smile: :happy:";
    //greedily match word in between colon and put it in a grouping that will be used in replace text
    var emoteRegExpGreedy = /:(\w+):/g;
    msg.replace(/:(\w+):/g, "<img src='$1.png'>"); //returns "hello world <img src='smile.png'> <img src='happy.png'>"
```
</figure>

Parenthesis are placed around the `\w+` and is accessed with the `$1` in the replacement text. Notice how the grouping is accessed in the replacement text with the `$` symbol in JavaScript. This symbol differs in different languages from what I understand.

## Lookahead and Lookbehind to validate a match

Lookahead and lookbehinds are additions to a standard expression that allow you to check whether the base expression either follows, or is followed by another expression. Lookahead and lookbehinds are not matched, as in they will not be returned by the regexp engine. This is helpful in that sometimes you just want to capture a subset of a complete expression. Lookaheads are performed with `(?=suchandsuch)` or `(?!notsuchandsuch)`. Lookbehinds are performed with `(?<=textbehind)` or `(?<!nottextbehind)`. Continuing the chat box example, lets say that we want to implement a feature where users can vote in a poll. Users can vote for a certain option by suffixing 'vote' to a number. Our goal is to intercept that number tied to the 'vote'.

<figure markdown="1">
  <figcaption>regexp lookahead </figcaption>

```javascript
    var msg = "I'm going to vote for 5_vote";
    //find matches where a digit is suffixed by '_vote'
    var voteRegExp = /\b(\d+)(?=_vote)/g;
    msg.match(voteRegExp); //returns ['5'];
```
</figure>

To be honest the example is contrived. Usually we would want to prepend 'vote_' but JavaScriptdoes not support lookbehind so I had to use look ahead in this example.

Okay! That does it. I know there's way more about regular expressions I gotta internalize but I think this is a good place to end for now.

## References and things

- [RegExper](http://www.regexper.com/) - Regular expressions as railroad diagrams
- [regexpal](http://regexpal.com/) - On the fly regular expression matching
- [Regex Crossword](http://regexcrossword.com/) - Crosswords where regular expressions are the hints.