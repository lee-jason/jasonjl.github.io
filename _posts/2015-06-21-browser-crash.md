---
layout: post
title:  "Logging Information on Browser Crashes"
date:   2015-06-21 01:00:00
description: "Logging client details on crashes"
# image: "awsnap.png"
categories: browsers, javascript, logging
comments: true
---


Every now and then your web application does something so wild and unpredictable that it crashes the browser that you're running it on. In order to create a better product for our users, we would need to log pertinent information every time our app crashes. Unfortunately there is no way to send a crash log before or during the crash due to the unpredictable nature of the crash and the browser's web environment no longer working. The best thing to do is to send the logs after the crash. This post will go through a technique to detect when the user's previous session has crashed so that we can perform the relevant logging actions.

## Preface

Currently I've only been able to support this technique on Google's Chrome and Mozilla's Firefox browser. This technique takes advantage of these two browser's support for restorable sessionStorage. The [WHATWG](https://wiki.whatwg.org/wiki/FAQ#What_is_the_WHATWG.3F) HTML spec currently describes sessionStorage to delete itself once the browser context ends but also makes a note that browsing contexts can continue to persist even after the browser is closed. This is useful if the browser chooses to save the session to reload it after the user closes the browser window or if the browser window crashes.

[WHATWG spec on sessionStorage](https://html.spec.whatwg.org/multipage/webstorage.html#the-sessionstorage-attribute)

## Simulating the Crash

First, we'll have to find out ways to simulate crashes on our browsers. Fortunately for our sake, its pretty easy to do for both Mozilla and Chrome.

### Crashing on Chrome

- Go to the page you want to crash
- Paste this into your url 'chrome://crash'
- Press Enter

That was pretty easy. This brings up Chrome's 'Aw Snap!' error page which simulates as if an irrecoverable error actually happened on the previous site you were on.

### Crashing on Firefox

- Go to the page you want to crash
- Open your Task Manager on Windows or Activity Monitor on OSX
- Find your firefox process and end the process or force quit it

Force stopping the processes trigger's Firefox's crash conditions and emulates a real crash scenario. Firefox should ask you to restore your previous tabs along with your previous session as well.

### Go ahead, try it!

Now that we know how to crash this page, go ahead and try it! When you come back there should be an alert letting you know that you came back from a crash and at what time

## Acting on the Crash

Now that we know how to crash the browsers we just need to place the code in.

```javascript
// Check if we're coming back from a crash
if (sessionStorage.getItem('good_exit') === 'pending') {
    // We're coming back from a crash
    alert('You came back from a crash at ' + new Date());
    // Do your crash logging here
    // You can access any sessionStorage data from the crashed session
}

// Set the good_exit flag to pending when the page loads
sessionStorage.setItem('good_exit', 'pending');

// Set up listeners for successful exits
window.addEventListener('beforeunload', function() {
    sessionStorage.setItem('good_exit', 'true');
});
```

The code above is checking if the user successfully closes, refreshes, or browses to another page by applying a `good_exit = true` flag in our sessionStorage. When the user successfully loads the page, the 'good_exit' flag will be set to 'pending' as we're not sure if the user will successfully exit from this session. If the user unsuccessfully closes, refreshes, or browsers to another page and manages to crash the browser, the 'good_exit' flag will not be changed to 'true' and will stay as 'pending. Everytime the user loads the page we check whether they're coming back from a crash. If they are, then we apply our crashalytics code.

## Things to do after a crash

Remember that your sessionStorage is saved and recovered so anything that your user was doing before the crash can be recovered. This means you can store the last visited url, the time that they visited your site, any actions they have taken on the page, anything that you can store in sessionStorage can be recovered.

Say for instance the last thing the user was doing before the crash was typing a very long response in a text box. You can save the contents of the text box every few seconds into sessionStorage so that you can reload it once the user comes back from the crash. Or if you just want some analytics on the last actions the user took you can create a sessionStorage item to log and trace the actions taken by the user by listening to clicks and key inputs on your document. When the visitor returns you can post that information back to your server so you have something to go on when trying to fix your buggy site. Or when a user comes back to your page you can directly ask them to submit a bug report about what they were doing before they crashed. Many native desktop programs already do something like this and now you too can bring this feature to your buggy web application!

## Caveats

An already listed caveat is this may or may not currently work for Internet Explorer or Safari. I wasn't able to reliable crash those browsers to test whether they bring back sessions after crashes. Another caveat is that since sessionStorage content isn't shared between tabs, users will have to refresh or reload the same tab with the same sessionStorage in order for the crash logging code to execute. If users open a new tab to connect after a crash then there will be no record of there being a crash. It will act as if you started a new browser session. As you can see this method isn't 100% reliable, but it does give options to cover some of your user base.

*tested on Chrome version 43.0.2357.81 and Firefox 38.0.5 on June 21, 2015*