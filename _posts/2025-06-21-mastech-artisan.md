---
layout: post
title:  "How I roast great coffee at home"
date:   2025-06-21 08:00:00
description: "A small guide on the tools that help me roast great coffee at home"
image: "Analyze1.png"
categories: coffee
---

You ever get sucked in so deep into a hobby that you start writing a guide on it then realize how much of a freak you are? Well if you haven't got there yet, I hope this guide will help you get a little closer to your goal.

If you're already into brewing your own coffee, then learning how to roast your own beans is a natural next step in your path to understanding and pursuit of the perfect cup. The subtle and nuanced decisions you make during the roasting process are arguably more influential on the resulting cup than any decision you make during the brewing process. By mastering the roasting process, you'll be able to have fine tune control over the resulting cup's character (bright vs bold) and the cup's texture (tea vs thick).

## Tools
Here's what I use
Links are provided for convenience. I'm not affiliated with any of the products.
{% include img.html page=page name="roast_setup.jpg" %}
- [FreshRoast SR800](https://www.amazon.com/dp/B07Z9Q3TLQ)
- [Mastech MS6514](https://www.amazon.com/Mastech-MS6514-Thermometer-Temperature-Interface/dp/B00KXC8YNK)
- [K Type Thermocouple](https://www.amazon.com/Thermocouple-Headprobe-Mini-Connector-Temperature/dp/B0BGXXGR1M)
- USB Mini to USB Adapter (Pick whatever your device takes)

Optional
- [Bean Cooler](https://www.amazon.com/dp/B07S9XYC48)
- [FreshRoast Extension Tube](https://www.etsy.com/shop/RazzoRoasting)

## Software
- [Artisan Scope](https://artisan-scope.org/download/)
- [USB to UART Driver](https://www.silabs.com/software-and-tools/usb-to-uart-bridge-vcp-drivers?tab=downloads)

## Hooking things up

- Turn on your Mastech and connect the Mastech to your computer.
- Hold the USB button until it beeps. Your PC should acknowledge a new USB device as connected.
{% include img.html page=page name="mastech-usb-setup.jpg" width=400 %}
- Open Artisan and configure the Device to use the identified Mastech device (Menu -> Config -> Device...)
{% include img.html page=page name="mastech-device-config.png" %}
- Configure the Port to use the usb port the Mastech is connected to (Menu -> Config -> Port...). 
{% include img.html page=page name="mastech-port-config.png" %}

At this point Artisan should be receiving temperature data from your Mastech device.

## What's next

You thought I was going to go into roasting theory in this guide? Sorry to say but there's too much on that topic to fit in this micro guide.
Here's a few links to get you started on the right path

[Sweet Maria's Coffee Library](https://library.sweetmarias.com/) \
Incredibly thorough and easily consumable resource to answer any question you may have about roasting

[The Captains Coffee](https://www.youtube.com/TheCaptainsCoffee) \
[Virtual Coffee Lab](https://www.youtube.com/@VirtualCoffeeLab) \
Both very good examples of what proper procedure looks like what the nuanced decision making that goes into it

Happy roasting