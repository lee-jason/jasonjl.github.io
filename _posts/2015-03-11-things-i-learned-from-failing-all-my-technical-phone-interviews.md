---
layout: post
title:  "Things I Learned From Failing Technical Interviews"
date:   2015-03-11 01:00:00
description: "Lessons learned from technical phone interviews and how to improve your chances"
categories: career, programming, interviews
comments: true
---

I just had a long month of technical phone interviews from numerous companies that I got from the technical job hunting service [Hired](http://hired.com). Its funny, you don't truly learn until you've actually made mistakes in a scenario that actually matters. With that being said, I think I learned a ton of lessons from getting rejected from many technical interviews and I want to share my insights with you!

## preface!

I have tried to remain objective in my learnings but there may be hints of bitterness here and there on the account of, you know, failing these technical interviews.

## The only winning move is not to play

Interviewing is a losing game. All applicants are losing, its just a matter of losing the least. From the time you say 'Hello' you're already losing. Your interviewers are expecting you to finish a task in a certain amount of time and once finished will compare your time and performance to that of your peers. They are not looking for things that will impress them but rather for things that will reduce their opinion of you. There is no way to 'win' an interview, only a way to lose the least. Say too many things that rub the interviewer the wrong way and you're out of the race.

## The odds are stacked against you

A typical technical interview path usually involves five or more gatekeepers you have to pass. You usually have to impress each of the following people in order to advance to the next level

- non technical Company Recruiter
- technical phone interviewer #1
- technical phone interviewer #2
- CTO/manager
- Take home assignment
- onsite interviewer #1
- onsite interviewer #2
- onsite interviewer #3
- onsite interviewer #4
- onsite interviewer #5
- onsite interviewer #6
- day two onsite interviewer #1
- day two onsite interviewer #2
- day two onsite interviewer #3
- day two onsite interviewer #4
- day two onsite interviewer #5
- day two onsite interviewer #6
- Congrats you got the job!

*The amount of interviewers has been expanded to indicate a nightmare interviewing scenario. Your interviews will probably not look like this, but is not outside the realm of impossibility*

Remember earlier when I said that technical interviews is a losing game? Imagine a scenario where you are actually a really good engineer (unlike me haha!), and you have a 99% chance of passing through each gatekeeper. This means that you ultimately have an 84% (.99^17) chance of passing through each gatekeeper and landing that job. The odds are good, but not guaranteed. Now imagine if you're a good engineer but you're no Linus Torvalds and you have a 95% chance of making it through each phase. That means you ultimately have a 41% (.95^17) chance of impressing everyone and getting the job of your dreams. If you're not within the top echelons of programming you might as well start practicing burger flipping because the only thing you'll be engineering is the perfect .99c cheeseburger at McDonalds. Okay, that was mean, but my point is, you can be very good at what you do and still be rejected because of an interview with a gatekeeper going very wrong, and that's okay!

## Fail Fast. Try, Try Again

Its okay to fail at these interviews. Failing a phone screen doesn't say anything about your character or intelligence. Say you have a 40% chance of getting past all the gatekeepers and landing a job. The probability of you landing that job at the first company you interview at is 40%, 1 - P(successive failures). The probability of you landing that job after two seperate company interviews is at 64%. The probability of landing the job after three seperate company interviews is 79%! Okay lets say you're a average engineer and you have an 80% chance of making it through each interview and there's 8 interviews to get through. We first calculate the probability of you getting past each gatekeeper and landing the job (.80^8) 16%. Ouch, not good. You have a 84% chance at failing to get a job at a company with 8 gatekeepers. Now we figure out if you only apply to companies that all use 8 gatekeepers in their employee process then you will have a 16% (1 - .84^1) chance getting in on your first try 30% (1 - .84^2) chance on your second, 41% (1 - .84^3) on your third , 51% (1 - .84^4)on your fourth okay you get the picture. Apply more to different companies and the odds start turning in your favor. You will make it. The thing is, is that interviews are not all cut and dry like a math problem. There's a lot of things you can't control such as the amount of interview gatekeepers and your probability of passing through each interview. While we can't ever get our acceptance probability to 100%, we can definitely do some things to improve those odds.

## Do not be yourself

Its kind of psychopathic, but do not be yourself. Be prepared to take on a persona of the most attractice engineer that has ever graced this planet. Never willingly give away anything that might expose your humanity. Technical interviews are like a reverse [Turing Test](http://en.wikipedia.org/wiki/Turing_test). Instead of tricking the user that you the are human, you have to trick the interviewer that you are in fact a robot. You do not make syntax errors, you do not need to consult apis, you do not need a calculator, you make informed decisions on every aspect of engineering. Working for a company is not an opportunity to research or make mistakes, companies don't want to hear that, they don't want to pay you for that. Its an opportunity for the company to buy you to offload work on the current team much like how they may buy an additional server for their load balancer. You are viewed as an additional core to their server cluster and you will act that way. You are not valued for your ability to learn quickly or your knowledge of all these cute esoteric language features. You are valued on how much raw computing you can do for the team. After you get the job feel free to be yourself and share all those cute little quirks about your favorite dead language, but until then, you must give off the persona that you are perfect.

## Do not panic

We are not perfect. Nobody is. We are flawed as human beings. We are not a compiler. We are not an interpreter. We are not a server core. We do not know every computer science principle, algorithm, strategy, pattern, data struct, language api, language feature. There is so much we don't know, and that's okay. If you don't know something and a gatekeeper deems you unworthy, so what. Who cares, you failed, move on. Its almost a guarantee that you will be asked something you don't know and even after an hour of thinking about it and problem solving around it you still won't know. It happens. The important thing is to not panic. You don't think well, or even think at all when you're panicking. Stay calm, stay cool, don't look at the clock, don't freak out. You will get questions you don't know the answer to, you will feel like an idiot after hours of interviews, you will realize your ignorance. Its cool, it happens, just make sure you're the calmest idiot in the room. Interviewers interview tons of people that don't know the answer to their question. They ultimately want to see if you can figure it out in less than an hour but do so by being calm and collected. Don't give the gatekeeper more ammunition to not let you move on to the next level by appearing hysterical.

## Do not talk

Do not talk too much that is. Say you're asked about a subject that you know truckloads about. Do not drone on and on and on hoping to impress your interviewer. They probably don't care. Remember, they are only looking for things to dock points off of and talking too much is actually a negative. Give the general answer, then ask if you can go further in depth. Every single technical interview help book/guide recommends to keep talking during your interview because your interviewer doesn't know if you're thinking or if you're just stuck. This doesn't mean talk all the time. Its incredibly difficult to blurt out a stream of consciousness and think at the same time. Take the time to close the yap and think. Let your interviewer know you're going to think for a little bit and actually do it.

## And Lastly, Culture Fit

One of the most disparaging reads I've read was about an interviewer that was gunning for Google. If you haven't read this blog, take a look at some of the [articles](http://iwillgetthatjobatgoogle.tumblr.com/archive). This person is dedicated, has a goal, and a company in mind, seems pretty intelligent and very motivated. [Unfortunately](http://iwillgetthatjobatgoogle.tumblr.com/post/19790649528/unfortunately) about four months into the blog creation and after ~120 articles about programming and computer science concepts, he does not make it. Even after answering all the questions correctly he was not offered the position(granted, there is no way to validate this other than taking his word for it). Even if you are Steve Wozniak, Bill Gates, Linus Torvalds, Tim Berners-Lee, or Al Gore, sometimes they will reject you just because you didn't gel with one of the gatekeepers. Maybe the gatekeeper was threatened by your intelligence, your smile, your dashing good looks, your charming voice, your chiseled chin, your flowing hair, whatever the case sometimes you get denied because you said, wrote, or did the wrong thing that may or may not be related to programming. It sucks, it happens, move on.

A way to get past this culture fit criteria is to be legitimately excited for the produce the company works on. Remind the interviewer before and after the interview about how excited you are about the product by asking questions about the product. How does it work, who builds it, who decides what goes in it? And if you aren't actually interested in the product, then feign interest. 'Wow creating A/B testing for ancient email web app to serve ads to a demographic that's age 50+ sounds like the opportunity of a lifetime!'.

## Conclusion

Be cool, remain positive, keep trying.