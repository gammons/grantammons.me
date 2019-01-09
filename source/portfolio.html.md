---
title: Grant Ammons - Portfolio
header: Portfolio
page: portfolio
---

## Work

### Director of Engineering at ConvertKit - Jan 2017 to present

[ConvertKit][ck] is an email marketing platform that focuses on creators.  

* Scaled engineering org from 3 to 18+ engineers (we're still hiring).  ConvertKit has [solid growth](https://convertkit.baremetrics.com/).  I joined when we were at around $6M in ARR, and I helped scale it to $14+M.
* Implemented many processes that were nascent or missing - hiring, software delivery, QA, reviews / promotions, etc.
* Scaled the team to squads, with squad leads
* Migrated production infrastructure from Heroku to AWS

### PipelineDeals - VP engineering - 2006 to late 2016

* Built [PipelineDeals][pld] with cofounders from idea to successful bootstrapped SaaS app generating millions in revenue.  Is employee #1.
* Hired and Manages 3 remote teams of awesome software engineers.
* [Ensures the culture is strong and vibrant](https://medium.com/@gammons/4-awesome-ways-to-level-up-your-dev-team-32ab43f90678#.z6bh97clv), even though we are all remote.  Developer happiness and productivity are my primary concerns, while at the same time keeping accountability with the business side.
* [Crafted + continually hones][scrum] software delivery process to ensure high quality and tight collaboration.  Strives to keep process minimal.
* Manages a large production infrastructure in AWS, overseeing 50+ instances.  Implemented best-in-class practices to ensure speed, scalability, and uptime.   Achieved 99.999% uptime in 2015.  Has kept infrastructure costs well below [SaaS averages][saas] by strategic use + planning of reserved instances.

## Products

### Ultradeck

* Built my own SaaS, called [Ultradeck](https://ultradeck.co).  It did not get traction, but I learned a ton about product development.

## Open source stuff

### Todolist

[Todolist][todolist] is an open source command-line task management app written in Go.

* Can be installed using Homebrew via `brew install todolist`.
* There is a [web view](http://demo.todolist.site) which is a single-page app that displays your todolist in a browser.  The web view is a single-page app (SPA) coded with React/Redux, ES6.

### fake_arel

[fake_arel][fa] is a gem I wrote in 2010 that allowed developers to use Rails 3 query syntax in Rails 2.  It accomplished this by clever use of named scopes.

* We used this in production at PipelineDeals for a year or so while we refactored our app and readied it for Rails 3.
* Worked as advertised, as we were able to drop out fake_arel and begin using Rails 3 arel seamlessly.
* fake_arel was featured on the [Ruby5 podcast][r5] in 2010.

[ck]: https://convertkit.com
[pld]: https://www.pipelinedeals.com
[todolist]: http://todolist.site
[saas]: http://www.forentrepreneurs.com/2015-saas-survey-part-2
[scrum]: https://medium.com/cto-school/ditching-scrum-for-kanban-the-best-decision-we-ve-made-as-a-team-cd1167014a6f#.u93fsg4qx
[fa]: https://github.com/gammons/fake_arel
[r5]: https://ruby5.codeschool.com/episodes/99-episode-97-july-27-2010
