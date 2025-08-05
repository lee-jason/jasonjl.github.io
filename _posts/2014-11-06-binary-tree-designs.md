---
layout: post
title:  "Problems: Binary Tree Designs"
date:   2014-11-06 08:00:00
description: "So I've been brushing up and working with binary trees recently and I was pleasantly reminded how binary trees can flex and change while still maintaining the same data. It was fun testing self balancing trees when they would keep changing up on me."
media: "herobinarytreeexample.png"
categories: algorithms, binary-trees, data-structures, programming, recursion
comments: true
---

So I've been brushing up and working with binary trees recently and I was pleasantly reminded how binary trees can flex and change while still maintaining the same data. It was fun testing self balancing trees when they would keep changing up on me. I got a little annoyed and my mind started to wander and wondered just how many different kinds of trees can a set of numbers create?

**Problem: Given the amount of nodes in a set, how many different binary tree structures can be made from it?**

The picture above shows three different tree examples based off three nodes. If we keep going, we find out that there's five total unique tree structures just through brute force. I don't care about which numbers fill in which node in this problem (although that does sound like quite the problem) I just care about the shape of the tree structure. With that said, I was having trouble figuring out all the different tree types for four nodes and I didn't even try for five nodes. That's the point where we give up and ask the computer

<figure markdown="1">
<figcaption>Recursive solution to tree pattern count </figcaption>

```java
public int binaryTreeCount(int nodes, int count){
    if(nodes==1){
        return count+1;
    }
    //simulate left node path
    count=binaryCount(nodes-1, count);
    //simulate right node path
    count=binaryCount(nodes-1, count);
    //simulate left right node path
    if(nodes >= 3){
        count=binaryCount(nodes-2, count);
    }
    return count;
}
```
</figure>

This recursive function is simulating a depth first search that's limited by the amount of nodes available to it. Once it reaches the end of a path, it adds one to the 'count' counter that gets passed back up and down the recursive stack. The function goes down the left path, and the right path, and also considers paths that can be generated from a node that branches into two paths with the third condition. I'm not a mathmagician but the runtime of this isn't so hot. I'm pretty sure I can make it better by storing the path counts for amount of nodes down a certain path in a reference table so I don't have to calculate the repeated calculations every time but I'm just kind of glad right now that I got the answer I wanted.