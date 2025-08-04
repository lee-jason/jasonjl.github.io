---
layout: post
title:  "JavaScript Inheritance"
date:   2015-02-12 01:00:00
description: "Understanding prototypal inheritance in JavaScript and how to implement subclassing"
categories: javascript, programming, inheritance
comments: true
---

As you may already know, Javascript has an interesting inheritance pattern called prototypal inheritance. You too can start using prototyping powers of Javascript with this one weird trick found by an Orange County mom. James Gosling creator of Java hates it!

Prototypal inheritance is similar to classical language's concept of extending. It has some of the same concepts of subclassing such as inheriting parent fields, overriding, and creating new fields. Here's a small example of how to subclass a JavaScript class.

```javascript
    //Parent class
    var Parent = function(){
        this.name = "parent"
        this.status = "adult";
        this.species = "human";
    }

    //Child class
    var Child = function(){
        this.name = "child";
        this.status = "infant";
    }

    //set Child's prototype to a new Parent object
    Child.prototype = new Parent();
    //re-set the Child's constructor to itself, since it was 
    //overwritten in the previous statement
    Child.prototype.constructor = Child;

    var child = new Child();
    console.log(child.name) //"child"
    console.log(child.status) //"infant"
    console.log(child.species) //"human" taken from Parent.species
    console.log(child instanceof Parent) //true
    delete child.name //true removed Child's name
    console.log(child.name) //"parent" taken from Parent.name
```

This is the basic structure. Each function has a `prototype` property. This `prototype` field is an object that is applied to all objects created from that function using the `new` keyword. Setting the prototype of the Child class to that of the Parent class will create a prototype chain which would then allow the `instanceof` feature to work. The Child class would also borrow any attributes it didn't have that the Parent object would supply. Deleting overriden attributes in the Child class would revert back to use the assigned Parent's attributes.

Prototypal inheritance in JavaScript is slightly more flexible than in a classical inheritance pattern due to the ability to extend Parent functionality without the Child knowing about it. Its not needed in a class signature but rather a simple assignment to Child's prototype attribute. Its also possible to selectively choose which attributes to inherit from the parent. Not all public attributes need to be in the prototype object before assigning it to the Child.

Javascript inheritance is definitely not as straightforward as Java's but there are ways to get the job done.