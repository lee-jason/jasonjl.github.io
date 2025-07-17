---
layout: post
title:  "Rendering List of Elements in React With JSX"
date:   2015-04-18 01:00:00
description: "Rendering a list in React"
categories: guide, javascript, jsx, react
comments: true
---

Understanding how JSX is processed can be slightly tricky to understand. Knowing when its appropriate to use JavaScript code and when to use HTML in your JSX can be very nuanced when writing React code. Understanding how the JSX will compile is critical in writing basic React that will render in predictable ways every time. This guide will go over the slightly tricky scenario of getting a list to render and how it can help us understand more about React and JSX.

**Preface:** Unfortunately, the JSX code highlighting may not be perfect. Each JSX React code example is followed by the transformed version to JavaScript, followed by the actual rendered code in the page. Feel free to inspect the elements to get a better idea of how React renders your code.

You may have landed here because you tried to render a list in React and wondered why it didn't work. You may have tried passing and rendering the list as a prop and wondered why your list is still all inline. You may feel this way if you came from an Angular background where rendering with ng-repeat was largely left to magic. React gives you a finer level of control that makes using it more easier to understand.

The following example shows what happens when simply rendering a list in React without any processing. Inspect the code and notice how all the elements are displayed in a single list item.

## Bad Example

**JSX**
```jsx
var SimpleList = React.createClass({
  render: function() {
    return (
      <ul>
        <li>{this.props.listItems}</li>
      </ul>
    );
  }
});
```

**Compiled to JavaScript**
```javascript
var SimpleList = React.createClass({
  render: function() {
    return (
      React.createElement("ul", null,
        React.createElement("li", null, this.props.listItems)
      )
    );
  }
});
```

**Rendered Result**
The above example doesn't cut it.

You may also have tried to individually pick out elements in the array and plant them in your render code. This would work, but its not very flexible. Notice how the second render call with the longer list is only able to display the first five elements.

## Bad Example

**JSX**
```jsx
var SimpleList = React.createClass({
  render: function() {
    return (
      <ul>
        <li>{this.props.listItems[0]}</li>
        <li>{this.props.listItems[1]}</li>
        <li>{this.props.listItems[2]}</li>
        <li>{this.props.listItems[3]}</li>
        <li>{this.props.listItems[4]}</li>
      </ul>
    );
  }
});
```

**Compiled to JavaScript**
```javascript
var SimpleList = React.createClass({
  render: function() {
    return (
      React.createElement("ul", null,
        React.createElement("li", null, this.props.listItems[0]),
        React.createElement("li", null, this.props.listItems[1]),
        React.createElement("li", null, this.props.listItems[2]),
        React.createElement("li", null, this.props.listItems[3]),
        React.createElement("li", null, this.props.listItems[4])
      )
    );
  }
});
```

**Rendered Result**
A good solution would be flexible to the amount of items in a list and would render with its own containing element in a repeating fashion. Notice how the following render function is able to accomodate arrays of all sizes. This is due to rendering in a list of React Elements created from the list of numbers coming in from the props.

## Good Example

**JSX**
```jsx
var SimpleList = React.createClass({
  render: function() {
    return (
      <ul>
        {this.props.listItems.map(function(listValue){
          return <li>{listValue}</li>;
        })}
      </ul>
    );
  }
});
```

**Compiled to JavaScript**
```javascript
var SimpleList = React.createClass({
  render: function() {
    return (
      React.createElement("ul", null,
        this.props.listItems.map(function(listValue){
          return React.createElement("li", null, listValue);
        })
      )
    );
  }
});
```

**Rendered Result**
The solution above is flexible enough to accomodate as many or as little list items that comes from the props field.

## Lets break it down to see why it works

First each React class object needs to have a render function. Think of the render like a screen refresh. The render function is supposed to return a value or list of values (most commonly composed of React Elements) that will be drawn onto the screen. The render function is automatically called whenever the object's state is signalled to change. States are outside the scope of this guide but you can read more about state [here](https://facebook.github.io/react/docs/tutorial.html#reactive-state).

Notice how HTML is plainly inserted into a JavaScript function. The JSX transformer/compiler will automatically detect HTML and React tags inside JavaScript and convert them to the equivalent JavaScript expression. If you would like to read more about the end result feel free to [try out](https://facebook.github.io/react/jsx-compiler.html) the compiler and [read up](https://facebook.github.io/react/docs/jsx-in-depth.html) on what it does to your tags.

Also take note of the curly brackets peppered through out the HTML tags. The brackets signify to the JSX transformer that there is actual JavaScript inside of it. Combining JSX and JavaScript together allows us to use the ease of HTML tagging and the logical power of JavaScript to create dynamic HTML templates right inside of our React code. In the case of the list example, note how we start with a containing `<ul>…</ul>` block. This `</ul>` block is then split with a pair of brackets that perform a [mapping](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/map) to create and return a new list of React Elements `<li>{listValue}</li>`. Also notice again how `{listValue}` had to be surrounded again in brackets since its embedded within HTML elements. If you want to know more about what you can do with React Elements take a look [here](https://facebook.github.io/react/docs/top-level-api.html#react.createelement).

## Conclusion

The React renderer is actually quite flexible. You don't necessarily have to feed it just Numbers or just React Elements but can mix and match all sorts of JavaScript objects. You can filter and parse the original objects in your list and use JavaScript logic to render a completely new list with dynamic React Elements. You can even plug in your own Custom React components in your render function as well, but you already knew that didn't you. Truly understanding how your JSX code will be compiled to plain old JavaScript is the key to writing predictable React everytime.