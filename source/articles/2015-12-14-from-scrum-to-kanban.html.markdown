---
title: Ditching Scrum for Kanban - The best decision we've made as a team
date: 2015-12-14 18:21 UTC
tags: engineering process software
cover: copenhagen.png
page: blog
---

The following is a story about how we matured as an engineering team.  We went from an ad-hoc process to Scrum, and used Scrum for a whole year.  Scrum leveled us up as a team in terms of structure and process.  But it caused major morale issues.  Then we found Kanban.  We implemented it and have never looked back.

<!--more-->

## From nothing to Scrum

We started using Scrum after using a strange, ad-hoc system of developing software.  There was a perception from the rest of the company that things were disorganized.  We did not have a PM and did not have a great communication channel to the rest of the company.  No one knew when things were shipping or what they included when they shipped.  We had quality issues because QA was not a big part of the process, and we did not do peer code reviews, so we spent more time fixing bugs than shipping features.

We knew we need to get more organized and disciplined, so we hired a Scrum coach.  We decided as a company that if we want this process to work, we'd get the entire company on board with the approach.  In retrospect this was the correct move, as all departments got a benefit from the 2 week cadence.  The coach came in for 2 days, gave us a concentrated lesson Scrum, agile, and how it all works.

We were told that the first few sprints will be a little strange, because we will not be great at estimating, and that this is a skill that will be honed over time.  So we did the first few sprints and indeed, we found that we would grossly over- or underestimate the amount of work we could do in 2 weeks.  Over time we got better.

Scrum forced us to get more disciplined about upcoming features.  The engineers needed wireframes, workflows, and light specs in order to properly estimate the work.  We quickly realized that we needed a product manager to facilitate this work and to effectively communicate back to the rest of the company.  We had to do more up-front planning for the feature. These were all good things and were part of us maturing as an engineering team and product company.

The rituals, mainly the standups and grooming sessions, were fantastic.  Standups are a great way to keep everyone aligned on the work.  The grooming sessions were grueling - usually 2-3 hour sessions to ensure we had everything properly tasked.  But, at the end, we all had a very good idea of the work that was ahead of us.

The retrospective meetings started out great.  As we were honing the process, we had a lot to talk about.  We frequently referred back to the reference material the coach gave us.  Sometimes we even sent him an email or had a quick skype session to figure out the best way forward.  We learned a lot.

## But then...

After a dozen or so sprints under our belt, we started to notice some things.  The first is that it is *extremely* hard to accurately plan 2 weeks of work.  The vast majority of the time, we'd overestimate the amount of work we could do.  Granted, we did get more disciplined about estimating and we eventually fell into a cadence.  But still, we were off every time.

Many of the reasons wern't directly within our control.  Maybe it was the 3 critical bugs that we needed to fix, causing the sprint to get out of whack.  Or maybe it was the team lead's unplanned visit to the dentist.  Or the site went down requiring a half a day of the entire team. Or <insert real life event here>.

Usually we'd carry over a story or 2 because a couple of tasks were still incomplete from the previous sprint.  This occurred very often, and because of that, morale was a major issue.  Everyone's morale sunk during sprint turnover periods.  The PM (although he didn't say this outright) probably thought we were slacking as a team.   Multiple times I heard "Well, we know we can only do less than half of what we plan for."  Gee, I wonder how that made everyone feel?  The reality is that the developers were probably cutting corners and not putting the proper time into properly implementing a task.

I remember once we planned a sprint that included only about 25% of what we actually thought we could handle, and we barely made it.  Say what you want about our supposed inability to estimate, but I challenge any team to nail estimates within a 20% margin for a large feature on a large app.

We carried on with sprints for a year.  **Despite the fact that Scrum made our product team so much better in so many ways, our team's morale was cratering.**  We were more organized.  We were shipping excellent code that was higher quality than we've ever shipped.  And we were miserable!

## The search for a better way

I started to look for different ways of developing software.  I even thought about going back to our "disorganized" way of shipping software.  What I needed was advice.  So I grabbed a coffee with [Peter Bell][5], who is the cofounder of the [NYC CTO School meetup][2].  Peter is a smart guy and has had exposure to a lot of teams in the same predicament.

I remember just unloading all of my thoughts onto Peter.  It was if I was at a "CTO therapy" session.  I talked and talked, listing all of the problems we were having with Scrum, why it's not working, and what we can do.  Are we doing Scrum wrong?  Should we get our coach back in?  Is our engineering culture just not a good fit for Scrum?  And he listened intently.  And then he recommended Kanban.

Peter told me that indeed, many companies follow the same path that we did.  They go from no system to scrum, which teaches them the disciplines they need to properly develop software.  Then, as teams fully understand Scrum, its disciplines and rituals, teams have *the option* to move to Kanban.

## To Kanban

[Kanban][3] is basically Scrum with the sprint goalposts removed.  It is an "endless" sprint.  Given the goalposts were the pieces that were making my team miserable, Kanban was exactly what my team needed.   We implemented Kanban just about 1 year after implementing Scrum.

We kept almost all the rituals of Scrum - albeit the ones we saw use in.  We kept the tasking sessions and the standups.  We tossed out the retrospectives.  We kept the board, so we knew what state all the tasks were in.  We kept our deadlines and our cadence.  Tasking has become more of an "on demand" meeting.  We task when we need to, and not at a prescribed time or date.

Not much has changed otherwise.  Moving from Scrum to Kanban felt very natural and was not a jarring transition.

**Since we have implemented Kanban our teams have become much happier**.  And really, that was the driving force of the change.  No longer were we cramming at the end or feeling bad when multiple stories didn't get finished.  We are able to get things done correctly, all while being in constant communication with the PM about the deadlines.

One of the major questions I had when moving from Scrum to Kanban was if we would lose our sense of urgency.  But that has not happened.  **It turns out that cramming to make a sprint deadlines was not the major motivating factor to get work done**.  We still have deadlines, and we still have a strong, motivated set of engineers and team leads.    Our engineers already feel intrinsic motivation for a number of reasons, but I believe it's because [we care very deeply about ensuring developer happiness][1].

Kanban works well for our team and our company.  [It has also worked for other companies as well][4].  Perhaps Kanban is better suited towards long-lived product development than Scrum.  Perhaps there is indeed a natural progression of engineering teams adopting Scrum, then moving to Kanban.   From my standpoint we were struggling with Scrum and are Thriving with Kanban.  It's the best decision we have made as a team.

[1]: https://medium.com/@gammons/making-20-time-work-for-your-engineering-team-d73adf699038#.4me00qy0d
[2]: http://www.meetup.com/ctoschool
[3]: https://www.youtube.com/watch?v=Jx6_E5XxqEo
[4]: https://stormpath.com/blog/so-long-scrum-hello-kanban
[5]: https://twitter.com/PeterBell

