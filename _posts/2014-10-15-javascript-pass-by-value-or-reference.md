---
layout: post
title:  "Javascript, Pass by Value or Pass by Reference?"
date:   2014-10-15 08:00:00
description: "This is something you don't have to question until you need to pass the contents of an object around or pass the same exact reference around. For me this knowledge became important during the development of Angular and Node applications where objects and primitives are passed around like a hot potato."
media: "javascript-pass-by-reference.mp4"
categories: javascript, programming, memory-management, pass-by-reference, pass-by-value, tutorial
comments: true
---

# Javascript, Pass by Value or Pass by Reference?

This is something you don't have to question until you need to pass the contents of an object around or pass the same exact reference around. For me this knowledge became important during the development of Angular and Node applications where objects and primitives are passed around like a hot potato.

## So is it pass by reference or pass by value?

Javascript uses a pass by value strategy for primitives but uses a [call by sharing](http://en.wikipedia.org/wiki/Evaluation_strategy#Call_by_sharing) for objects. Call by sharing is largely similar to pass by reference in that the function is able to modify the same mutable object but unlike pass by reference isn't able to assign directly over it. If you can stretch your imagination a bit, call by sharing is kind of what the name implies. Outside objects passed into the function are shared, but once the function decides to overwrite it, the sharing is off and the function only plays with its own version.

<figure markdown="1">
<figcaption>primitives passed by value </figcaption>

```javascript
//created original object with property 'original'
var obj = {};
obj.original = "original";

//function that will add a new property to an object passed to it, and will also try to reassign the object in vain.
function prototypeProperty(obj){
    //add new property attribute to object
    obj.property = "new property";
    //edit the original text of the .original property
    obj.original = "edited"
    //function will overwrite the external reference with a new reference
    //does not affect the external object
    obj = {}
}
</figure>

prototypeProperty(obj);

console.log(obj.property) // "new property", note how the original obj is not empty 
console.log(obj.original) // "edited", even though strings are immutable, the function was changing the properties of the mutable object, not the string.
```

<figure markdown="1">
<figcaption>arrays call by sharing </figcaption>

```javascript
//create new array
var arr = [1, 2, 3, 4, 5]

//function that changes first two array values, pops the last value, and replaces the external reference with its own internal reference.
function modifyArray(arr){
    //update the first two array values
    arr[0] = 100;
    arr[1] = 200;

    //remove the last array value, array is now length 4
    arr.pop();

    //futilly try to replace the array with another one
    //only the internal arr has been replaced, the original arr outside this scope is still the same
    arr = [-2534,-345,-3463,-4536,-6453];
}

//pass in the og array
modifyArray(arr);

console.log(arr[0]); //100 note how none of the array values are reflecting the new negative values
console.log(arr[1]); //200
console.log(arr.length) //4
```
</figure>

## What is pass by reference?

Pass by reference is when variables passed in to functions are given the direct memory address. This allows the function to manipulate the object or primitive as it exists outside the scope of the function. The assignment operators that were 'reverted' in the previous examples would be applied once the code exited the scope of the function. This is a generally unsafe way to program due to functions having the ability to make assignments to the initial variable. Although I've never used it, from what I read, FORTRAN and Haskell and C with pointers uses a pass by reference evaluation strategy

## What is pass by value?

Pass by value means that when you pass that variable into a function its the equivalent of creating a new var and making a copy of the passed in var. They're not necessarily the same exact variable in the same exact memory address but rather copies. Modifying the copy does not affect the original. By having functions have predictable outcomes. Programmers can rely that functions will not alter their original variable and would always return a new copy that they can decide to use after the function exits. This is generally a safer way to program by preventing the programmer from overriding variables within functions. Many modern programming languages employ this strategy when it comes to primitives such as Javascript, Java, C#

<figure markdown="1">
<figcaption>primitives passed by value </figcaption>

```javascript
//set initial values
var str = "string";
var num = 1;
var bool = true;

//function that reassigns values
function passValue(str, num, bool){
    //new variables are copied with the value of the original variables
    str = "othervalue";
    num = 10000;
    boolean = false;
}

//call function that reassigns values
passValue(str, num, bool);

//original variables don't change
console.log(str); // "string"
console.log(num); // 1
console.log(bool); // true
```
</figure>

## What is mutability?

Mutablility describes whether a certain object is mutatable or changeable after its been created. Arrays and Objects are considered to be mutable in Javascript. They have functions that actively change the original object such as Array.splice or Object.prototype.

## What is immutability?

Immutability is, you guessed it, describes an object or primitive that's not mutatable after its been created. Javascript primitives such as booleans, Strings, integers are not modifiable. Now this can be confusing because you change boolean flags in your code or add incrementers to your integer variables or modify strings all the time. What mutability means is whether the same object, the same primitive itself can be modified and still be the same. When your code changes a boolean flag from true to false in your code, or have an integer incrementer, or updates a string to lowercase you're getting a brand new value that overrides the original value. Excuse the terrible analogy but you're unable to renovate the original house so you destroy it and plant a new house on top of it.

## What is a primitive?

primitives differ from language to language but they are generally the most basic immutable value as declared by the programming language. The primitives in Javascript are booleans, numbers, and strings and these are all immutable. Everything else is either an object or undefined (or NaN or null).

## The wrap up

So there you have it. When objects are passed into functions, a copy of the address goes in. That's why you're able to manipulate the original mutable object in the function. Everything you would want to know about Javascript and its objects.