---
layout: post
title:  "How Much Stuff Can You Fit in Memory?"
date:   2015-02-04 01:00:00
description: "Understanding memory capacity and how many data types you can store in different amounts of RAM"
categories: programming, memory, computer-science
comments: true
---

<style>
  tr:nth-child(2n+1) {
    background-color: aliceblue;
  }

  table {
    position: relative;
    left: -20%;
    width: 900px;
  }

  ul {
    font-size: $small-font-size;
  }
</style>

So you're given a limit on the amount of random access memory your program can use, how much stuff (ints, chars, booleans, bytes) can you cache in there before having to store it in physical media?

| Exponent Form | Exact Value | Approx Value | Bytes | bits (Bytes * 8) | ints (Bytes / 4) | chars (Bytes / 2) |
|---|---|---|---|---|---|---|
| 2<sup>0</sup> | 1 | 1B | 8b | | | |
| 2<sup>1</sup> | 2 | 2B | 16b | | 1 char | |
| 2<sup>2</sup> | 4 | 4B | 32b | 1 int | 2 chars | |
| 2<sup>10</sup> | 1024 | 1 thousand | 1KB | 8Kb | ~250 ints | ~500 chars |
| 2<sup>16</sup> | 65,536 | | 64KB | 512Kb | 16K ints | 32K chars |
| 2<sup>20</sup> | 1,048,576 | 1 million | 1MB | 8Mb | 250K ints | 500K chars |
| 2<sup>30</sup> | 1,073,741,824 | 1 billion | 1GB | 8Gb | 250M ints | 500M chars |
| 2<sup>32</sup> | 4,294,967,296 | 4 billion | 4GB | 32Gb | 1G ints | 2G chars |
| 2<sup>40</sup> | 1,099,511,627,776 | 1 trillion | 1TB | 8Tb | 250G ints | 500G chars |

## In case if you forgot…

<ul class="small">
  <li>Data types are represented by bits</li>
  <li>8 bits make a byte</li>
  <li>1 byte (or 8 bits) make a boolean</li>
  <li>2 bytes (or 16 bits) make a char</li>
  <li>4 bytes (or 32 bits) make an int</li>
  <li>8 bytes (or 64 bits) make a long [this is not shown in the chart]</li>
  <li>There are a total of 2^16 (~65k) character representation in Java</li>
  <li>There are a total of 2^32 (~4 billion) int representation in Java</li>
  <li>Each character and integer can be represented through hex</li>
  <li>\u0000, \uFFFF represent characters where each character represents a byte</li>
  <li>0x00000000, 0xFFFFFFFF represent integers where each character represents a byte</li>
  <li>Each 2^(10*n) breaks another thousand barrier</li>
</ul>

So say you have N amount of bytes to work with. If we want to know how many ints we can fit in there, we take N/4 since each integer uses four bytes.

Say we want to fit all integers into an array in memory. How much memory to do we need? we take all the integers (2^32) then multiply it by 4 since each integer is represented by four bytes. We would need roughly 16GBytes of memory to put all representable integers into an array

The conversions are for the most part simple, it just requires careful calculation around big numbers.

*note: all primitive types are based on the Java language. Table is an extension of Gayle Laakmann Mcdowell's Powers of 2 in [Crack the Coding Interview 5th edition](http://www.careercup.com/book)*