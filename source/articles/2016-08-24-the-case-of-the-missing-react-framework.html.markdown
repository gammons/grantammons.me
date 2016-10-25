---
title: The Case of the Missing React Framework
date: "2016-08-24"
tags: rants
cover: react-malaise.png
---

Learning [React](https://facebook.github.io/react/) is easy, but learning how to properly architect an app using React is an exercise in frustration. React is just the view layer and Flux is a pattern for updating views. But there is a large gap - how to organize your data in a React app. And while React is an amazing library, Facebook left the data organization part as an exercise for the reader. And this, I believe, is a big problem.

Because Facebook left React as just a component of an as-yet undefined framework, the Javascript community was forced to define the rest of that framework themselves. And while certain libraries and patterns have stood out from the pack, it is completely daunting and paralyzing to a newbie trying to figure out where to even start. There are a large number of libraries, patterns, and tools to organize data with React, and Facebook does not help you with these choices.

> Facebook left data organization as an exercise to the reader.

Separating data concerns from React views is fundamental to architecting a clean app with React. You can’t use just React to write an app of any real significance. You’ll incur a lot of technical debt quickly. Why? Because it’s stupidly easy for your app to become very disorganized quickly. You have no choice but to deeply intermingle your data and complex interactions with your views.

The next best thing is to reach for a boilerplate. There are literally hundreds of React boilerplates to choose from. These boilerplates are essentially the frameworks individuals from the community have cobbled together in the absence of an official framework.

But here’s the problem with these boilerplates — who is to say that one framework’s decisions are “better” than another’s? Or which libraries should or should not be included and why? Most boilerplates are intended to be used by power users who already know the libraries they include. The authors of [React-boilerplate](https://github.com/mxstbr/react-boilerplate) provide great documentation for the scripts and generators it uses, but they do not include comprehensive documentation for how to use *all* the libraries it includes. And why would they? They are not intending for it to be the official framework; they assume you already know how to use all the included libraries. This is something that a full-fledged framework *would* (and should!) do, and it’s exactly what new users need.

[Dan Abramov](https://twitter.com/dan_abramov), one of the clear community leaders, [made a flowchart](https://github.com/gaearon/react-makes-you-sad) in an attempt to quell the masses about just learning react and not worrying about “missing out” on libraries, techniques, or features. I would agree with him that boilerplates are not for newbies or learning React. But this is the actual problem! New developers *need to know* that they need to separate their data from their views.  And they also need to know *how to do that*. The boilerplates are *numerous and intimidating*. The number of libraries and techniques to learn, and even choosing *which* libraries and techniques to learn is a *daunting* and *paralyzing* task. But the thing is, developers new to React need to know about separating their data from their views, and the best ways of how to do that. The lack of a clear direction from the community leaders and Facebook is the real problem here.

> Developers new to React need to know about separating their data from their views, and the best ways of how to do that.

DHH once said (much to the [hemming and hawing](https://www.youtube.com/watch?v=E99FnoYqoII) of the community) that [Rails is Omakase](http://david.heinemeierhansson.com/2012/rails-is-omakase.html). Rails is a distilled, curated collection of the best libraries that make up a great framework, and DHH is the head chef. They provide sane defaults for the full stack, and they also have comprehensive documentation for how to use everything. This is exactly what the React community is missing. In the React community, everyone is a chef, regardless of your experience level.

Facebook needs to complete the picture. They need to pull together the best libraries, practices, and techniques, and release an official React framework. That would put a serious dent into the [Javascript Fatigue](https://medium.com/@ericclemmons/javascript-fatigue-48d4011b6fc4#.tt8ije73e) that many developers feel. At the same time, it would allow new React developers to easily learn how to make well-engineered React apps quickly.
