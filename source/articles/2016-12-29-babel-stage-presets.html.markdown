---
title: A quick reference on ECMAScript Maturity Stages
date: 2016-12-29 18:19 UTC
tags: Javascript
comments: true
---

I wrote a quick reference on maturity Stages for ESnext Javascript features.  It's important be careful using features that are in stage 2 and below.

![](/images/ecmascript-maturity-stages.png)

Babel has presets that will automatically include the Javascript features for that particular stage.  I recommend you stick with [preset-stage-3](https://babeljs.io/docs/plugins/preset-stage-3/), as those features are the least likely to change, and are the most likely to be included in the yearly spec ratification.

To get an idea of which features are in which stage, reference the [ECMAScript compatibility table](http://kangax.github.io/compat-table/esnext/).

This quick reference is also [hosted on CodePen.](https://codepen.io/gammons/full/yVmzBR/)  Enjoy!
