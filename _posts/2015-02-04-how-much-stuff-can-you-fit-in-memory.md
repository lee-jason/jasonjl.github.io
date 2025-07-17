---
layout: post
title:  "How Much Stuff Can You Fit in Memory?"
date:   2015-02-04 01:00:00
description: "Understanding memory capacity and how many data types you can store in different amounts of RAM"
categories: programming, memory, computer-science
comments: true
---

So you're given a limit on the amount of random access memory your program can use, how much stuff (ints, chars, booleans, bytes) can you cache in there before having to store it in physical media?

| Exponent Form | Exact Value | Approx Value | Bytes | bits (Bytes * 8) | ints (Bytes / 4) | chars (Bytes / 2) |
|---|---|---|---|---|---|---|
| 2^0 | 1 | 1B | 8b | | | |
| 2^1 | 2 | 2B | 16b | | 1 char | |
| 2^2 | 4 | 4B | 32b | 1 int | 2 chars | |
| 2^10 | 1024 | 1 thousand | 1KB | 8Kb | ~250 ints | ~500 chars |
| 2^16 | 65,536 | | 64KB | 512Kb | 16K ints | 32K chars |
| 2^20 | 1,048,576 | 1 million | 1MB | 8Mb | 250K ints | 500K chars |
| 2^30 | 1,073,741,824 | 1 billion | 1GB | 8Gb | 250M ints | 500M chars |
| 2^32 | 4,294,967,296 | 4 billion | 4GB | 32Gb | 1G ints | 2G chars |
| 2^40 | 1,099,511,627,776 | 1 trillion | 1TB | 8Tb | 250G ints | 500G chars |

## In case if you forgot…

- Data types are represented by bits
- 8 bits make a byte
- 1 byte (or 8 bits) make a boolean
- 2 bytes (or 16 bits) make a char
- 4 bytes (or 32 bits) make an int
- 8 bytes (or 64 bits) make a long [this is not shown in the chart]
- There are a total of 2^16 (~65k) character representation in Java
- There are a total of 2^32 (~4 billion) int representation in Java
- Each character and integer can be represented through hex
- \u0000, \uFFFF represent characters where each character represents a byte
- 0x00000000, 0xFFFFFFFF represent integers where each character represents a byte
- Each 2^(10*n) breaks another thousand barrier

So say you have N amount of bytes to work with. If we want to know how many ints we can fit in there, we take N/4 since each integer uses four bytes.

Say we want to fit all integers into an array in memory. How much memory to do we need? we take all the integers (2^32) then multiply it by 4 since each integer is represented by four bytes. We would need roughly 16GBytes of memory to put all representable integers into an array

The conversions are for the most part simple, it just requires careful calculation around big numbers.

*note: all primitive types are based on the Java language. Table is an extension of Gayle Laakmann Mcdowell's Powers of 2 in [Crack the Coding Interview 5th edition](http://www.careercup.com/book)*