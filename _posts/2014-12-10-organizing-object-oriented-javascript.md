---
layout: post
title:  "Organizing Object Oriented Javascript"
date:   2014-12-10 08:00:00
description: "Object oriented Javascript isn't really a new concept. For years people have been trying to make JavaScript more familiar towards object oriented programmers by perverting its naturally prototypical architecture towards something more classical."
categories: guide, javascript
comments: true
---

Object oriented Javascript isn't really a new concept. For years people have been trying to make JavaScript more familiar towards object oriented programmers by perverting its naturally prototypical architecture towards something more classical. There are many guides on how to create classes with private and public members and inheritance but there aren't as many guides on how to organize these into an actual usable and familiar project structure. I think the primary problem in why developers have so many varying ways of organizing their Javascript code is in that the language was never really meant to be built to such huge degrees. Large scale Javascript projects are popping up with the rise in popularity of NodeJS and large-scale front end frameworks that try to organize the usual mess that comes from hacking together a 'native' application experience on the web. The need for organized module JS is becoming increasingly important which is why I think I've found a pretty decent solution from the wide amount of options out there.

JavaScript can simulate classes, but how do you organize them in files? Native Java can support a single class in a single file as well as any additional subclasses within that file. Different classes are brought together in Java by specifying its dependencies at the beginning of each file with the 'import' keyword. Unfortunately at this current state there is no largely supported 'import' feature for JavaScript which brings JavaScript developers out of the woodwork to make up functionality for it. [RequireJS](http://requirejs.org/) seems to be a pretty good module loader that emulates the functionality of an import. This means that it's no longer necessary to rely on properly ordering your dependencies in `<script>` tags in your html, but rather declare dependencies directly in the JavaScript files themselves. This also means that you can just insert the script tag for just the RequireJS file in the html. This file will be the entry point of the program and simulates the `public static void main(String args[])` function for Java. Imports is a pretty awesome feature that JavaScript was missing in creating clean modular object oriented JavaScript.

```javascript
    //the equivalent of import Class1; import Class2;
    require(["./class1", "./class2"], function(Class1, Class2){
        var class1 = new Class1();
        var class2 = new Class2();
    });
```

Okay so now we have a way to 'import' js files together and specify dependencies, now we need to see what exactly we expose in these files. JavaScript has ways of hiding information from outside classes but RequireJS also has the option to choose which paramters/functions to expose to the outside world. I've been taking a look at the [Brackets](https://github.com/adobe/brackets) source code and the approach that they take is to expose public methods and properties through RequireJS's export object. This works as a method of information hiding but I think the problem with this is that instead of using JavaScripts construct of information hiding by using scoped variables in functions, the decision to create public or private variables/methods is left up to whether the human behind the code wants to expose it. It also changes the traditional view of JavaScript classes meaning someone who is already familiar with JavaScript will have to re-familiarize with how a RequireJS project is set up since methods and variables don't have to be encapsulated within a class function. Then again there is always a learning curve when an unfamiliar framework or library is used in a project.

RequireJS gives us a lot of options in what to show and what to hide. Traditionally RequireJS allows us to return a single object. This can be a primitive, or a JSON object, an object with properties, or a function. The method that Brackets took is through exposing several properties and objects defined in each JavaScript file through the 'exports' object. This method works as you can see from the [Brackets source code](https://github.com/adobe/brackets) but it assumes that the methods exposed through this object is from a singleton object. Further internal classes can be made for each singleton object and exposed through RequireJS `export` object. A good file to look at for an example would be the [Menus.js](https://github.com/adobe/brackets/blob/master/src/command/Menus.js). Checkout the exports at the bottom of the page, it exposes some of the variables and functions defined earlier but also ignores others keeping those private. As a naming convention they prefix these private attributes with an '_'. The export also exposes inner classes. These classes are created in a more traditional object oriented JavaScript fashion as in through a function. Check out its [api page](http://brackets.io/docs/current/modules/command/Menus.html) to get a better idea of the variables, functions, and classes each file exposes.

I know there's many ways to organize a JavaScript project but I don't agree with Bracket's implementation entirely. I think the way that Brackets exports the file as an already created singleton object is something that's not entirely familiar with people coming in from Java/C# backgrounds. While JavaScript is really good about creating singleton objects, it'd be more familiar for Java programmers to only expose the constructor function for each file. Each JavaScript class would then be created in the traditional [Javascript fashion](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Introduction_to_Object-Oriented_JavaScript) and methods would be [public or private](http://javascript.crockford.com/private.html) based off the standard JavaScript way made possible through function scoping and closure. I think this method of project organization would be more simpler due to people not having to adjust their ideas on what they traditionally know about object oriented JavaScript from Java/C# while also practicing a separation of code.

Here's a pretty contrived example of what I'm talking about.

[source code](https://github.com/lee-jason/BlogExamples/tree/master/RequireJSExample)

So in this program I'm modeling a Car object that takes in a Person object as a driver. These are split into separate JavaScript files. The index.html file has a reference to the require.js file which calls main.js as the program starter. The main.js is where a Car and Person object will be created to model a car with a driver. RequireJS allows us to require Car and Person as a dependency where it is passed into the main program as function parameters. Both car.js and person.js simply return JavaScript class functions where users are free to create objects from. This is the closest setup I can imagine that simulates a classical object oriented program structure.

Here's the content if you're too lazy to click on the source link

**main.js**
```javascript
    <!DOCTYPE HTML>
    <html>
        <head></head>
        <body>
            <h1>RequireJS Module Example</h1>
            <script data-main="js/main" src="js/require.js"></script>
        </body>
    </html>
```

Note that main.js imports Car and Person and simulates a person entering a car and going.

**car.js**
```javascript
    require(["./car", "./person"], function(Car, Person){
        var civic = new Car("sedan");
        console.log("car type: " + civic.type);

        var person = new Person("Jason");
        console.log("person name: " + person.name);

        civic.go(); //"no response"
        civic.loadDriver(person);
        civic.go(); //"no response"
        civic.start();
        civic.go(); //"vroom"
        civic.exitDriver();
        civic.go(); //"no response"
    });
```

Note that properties 'on' and 'driver' are arbitrarily private as an example to showcase that both privileged methods as well as prototyped methods work when imported into main.js

```javascript
    define(['./person'], function(Person){
        function Car(type){
            var on = false;
            var driver;
            this.type = type;

            this.start = function(){
                on = true;
            }
            this.stop = function(){
                on = false;
            }
            this.isOn = function(){
                return on;
            }
            this.loadDriver = function(person){
                if(person instanceof Person){
                    driver = person;
                }
                else{
                    driver = null;
                }
            }
            this.hasDriver = function(){
                return !!driver;
            }
        }

        Car.prototype.go = function(){
            if(this.isOn() && this.hasDriver()){
                console.log("vroom");
            }
            else{
                console.log("no response");
            }
        }

        return Car;
    });
```

**person.js**
```javascript
    define([], function(){
        var Person = function(name){
            this.name = name;
        }
        return Person;
    });
```