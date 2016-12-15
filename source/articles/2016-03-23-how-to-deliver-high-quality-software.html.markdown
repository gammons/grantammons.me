---
title: How to deliver high quality software
subtitle: "QA 101: Defining the terms, what works, and who does what"
date: 2016-03-23 12:21 UTC
tags:
  - software
  - processes
comments: true
---

When it comes to software, the term “QA” itself is highly loaded. Because what is it, really? Is it just a thing at the end of the software delivery line, where quality gets lovingly sprayed on at the end, achieving  a nice glossy sheen? Is it a separate department that bolts on quality, where the developers don’t really need to worry about it after they throw it over the wall? Is it that one integration test that one developer wrote, once, and it’s “probably good enough”? Of course not!

<div class="caption">
  <img src="/images/spray.jpeg" />
  QA being applied to our test subject. This is not how it works.
</div>


So what goes into the process of *actually delivering high quality software*? In essence, there’s 2 parts to this whole thing:

* **The QA step:** A verification check by a tester. It’s a series of testing, exploratory or automated, to ensure that newly built software is ready for prime time. When you Google “QA” you are generally reading about this step.
* **Development practices for writing high quality software:** The stuff that the developers can do throughout the entire development process to ensure their work will pass through those checks with flying colors. These are things like code reviews, ensuring proper unit + integration test coverage, and continuous delivery.

As an engineering leader, you need to define both of these parts. There are some practices that work better than others, and that’s what this post is about. So let’s run through the cast of characters in this crazy play:

### Developers

These are the people who put the quality in. Developers are the only people who can directly control the quality of software.

Developers also:

* Help other developers with the quality of their code by means of code reviews.
* Write unit and integration tests for the code they create.
* May write automated tests at the browser/user level, using a tool like selenium. They may get help from the tester as to which automated tests to write.


### Testers

Testers are people who test the software and find bugs. They can then bring awareness of those bugs to the developers.

Although developers are usually very good about finding errors in their own code, not everything will be found. Testers are akin to an editor reading an article that someone wrote. While the writer probably did proofread well, they never catch everything themselves.

Testers can help guide developers on which tests are important to write. These will likely be at the user level, but sometimes at a lower level as well. 

Testers may or may not write automated tests at the browser level using a tool like selenium. It depends on their skill set. Sometimes testers will write those tests, but other times they can tell developers to write those types of tests.

Skilled testers usually are very good at exploratory testing. They have a bizarre personality trait where breaking things, making things go haywire, and generally creating disorder and chaos is something they very much enjoy.

### Product Managers

Product managers can answer the question “Are we building the correct product?” They are are not looking for quality issues or bugs per se; they are instead looking to ensure the output matches their expectation for what the user should experience. 

Building a high quality feature is a waste of time if it does not match the PM’s vision. This is why the PM is also engaged in any changes.

## Practices that work well

So there’s a whole sea of practices that don’t really work. Handoffs, separate teams, throwing code over walls, no tests, and very large, complicated deployment processes are all signs that high quality software is not going to be delivered. So what does work?

**An integrated team.** One or more testers should be a full-fledged part of a development team. At [PipelineDeals][pd] we have 4 developers per team, and a shared designer and tester. The tester comes to all standup meetings and coordinates with the developers as to which parts of the project are ready for them to test. Testers should be involved at all phases of the development process, starting with reviewing mockups.

[pd]: https://www.pipelinedeals.com

Testers should not be a separate team that only gets involved in the late stages of the game. Nor should there be a *handoff* from dev to QA. Handoffs are a sign of a broken process and usually foster an [us-vs-them][u] mentality.

[u]: http://royrapoport.blogspot.com/2016/02/the-failure-of-us.html


**Developers test first.** Just as a writer wouldn’t hand over their work to their editor without proofreading it themselves first, developers should perform exploratory tests first.

Before a tester executes their test plan, bring all the developers in a room for a couple hours and test the system end-to-end. The developers will find things. Usually the things they find can be fixed in realtime, to avoid further delays in testing.

After the developers complete their own testing, the project will look much better than it did. The tester will waste less time with the low-hanging fruit and be able to concentrate on breaking things in much more devious and subtle ways.

**Automated tests.** The output of exploratory and plan-based testing should feed into automated acceptance tests. Either the tester or developers can write these automated tests, depending on the tester’s skill set.

<div class='caption'>
  <img src="/images/baby.jpeg" />
</div>

**Code reviews.** Code reviews are an excellent way of ensuring the quality of code that is going to be merged into master. Developers never want to look bad in front of their peers, so usually they will always go above and beyond to ensure their work will stand up to a review.

A code reviewer should be looking for the following:

1. Is this code maintainable? Is it understandable? Will developers 6 months from now want to strangle the person who wrote it? We generally look to [Sandi Metz’s rules][r] as a guide.
2. Does it have proper tests at the proper level? Code changes should always include unit tests, but sometimes (especially if coding across APIs) they should also include functional or integration tests as well. Do the tests exercise the code properly?

[r]: https://robots.thoughtbot.com/sandi-metz-rules-for-developers

**[Continuous Delivery][cd]** conveys [tangible benefits][tb] to an engineering org. It reduces development costs and increases quality.

[cd]: http://martinfowler.com/bliki/ContinuousDelivery.html
[tb]: http://radar.oreilly.com/2014/02/the-case-for-continuous-delivery.html

We use feature flags extensively at a PipelineDeals. It allows us to iterate on new feature development while keeping small, short-lived branches. Because repeat after me: long-running branches are a *Bad Thing*. Why? Well, do you really think merging that 3-month-long mammoth of a branch into master, with the intention of deploying it on a Friday afternoon is going to go swimmingly? (It will not.) Large changes carry large risks.

Feature flags allow you to iterate on new feature development all while merging changes directly into the master branch, and it minimizes the risk that large branches carry with them. 

The other benefit is a staged rollout. You can flip a feature on for your beta testers, or to a predetermined % of users. Staged rollouts allow you to do many things:

* Launch early to beta testers for user feedback
* Launch to a small % of users as a [canary release][cr]
* Launch to a predermined cohort of users to guage performance impact
* A/B testing

[cr]: http://martinfowler.com/bliki/CanaryRelease.html

## Your field guide to QA

When I was put in charge of engineering at PipelineDeals, one of my goals set forth by the cofounders was to ensure the delivery of high quality software. That included implementing a solid QA process. When Googling about that, of course, you get slammed with all sorts of different practices and results. The above is what works well for us, as a SaaS product company. Your Mileage May Vary.
