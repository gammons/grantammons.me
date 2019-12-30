---
title: Grant Ammons - Portfolio
header: Portfolio
page: portfolio
---

[Download my resume][https://github.com/gammons/resume/blob/master/resume.pdf]

# Work

## Director of Engineering at ConvertKit - Jan 2017 to present

[ConvertKit][ck] is an email marketing platform that focuses on creators.

**Highlights**

* Scaled engineering org from **3 to 18+ engineers** (we're still hiring).  ConvertKit has [solid growth](https://convertkit.baremetrics.com/).  I joined when we were at around $6M in ARR, and I helped scale it to $18+M.
* Implemented many processes that were nascent or missing - hiring, software delivery, QA, reviews / promotions, etc. Helped ensure each process is effective.
* Scaled the team to squads, with squad leads.
* Migrated production infrastructure from Heroku to AWS.
* Helped set up teams to handle compliance + deliverability.
* Helped scale infrastructure to handle 1B+ email sends / month, as well as managing click, open, and delivery events in realtime.

I'm extremely proud of what I've accomplished to date at ConvertKit.  I joined as Director of Engineering when the company had 3 engineers.  We were onto something - the company was bootstrapped by Nathan, our CEO, and we manged to get enough growth to see about $5M in ARR and a few thousand paying customers.

However, there was an enormous mountain of technical challenges.  The app was down frequently, and email sending delays were common.

The first step was to right the ship from a software delivery standpoint.  Before I arrived, there was little rigor around code review, testing, or QA.   So for the first few months I acted as a technical leader and personally reviewed every PR.  I established learning goals for engineers who needed to level up. 

I established a rigorous hiring process and pipeline, and started hiring talented senior engineers and SREs.  This also had a great collateral effect of leveling the team up.  We began to start really making inroads in retiring some of our most egregious technical debt, and we gained confidence that our new feature releases would be reliable and wouldn't break with our scale.

From an infrastructure standpoint, I hired an SRE team that got busy.  We migrated from Heroku to being fully on AWS, over a period of about 4 months.  We went from having consistent email sending delays to processing everything nearly instantly by adopting Cassandra for storing email events, and retiring our usage of a single Mysql database setup.

We slowly began to pull ourselves out of having the company face a near technical disaster to having an engineering team that ships great code, an app that has great uptime, and having a culture of engineers who are happy and not burnt out.  It's been an amazing achievement and transition.

Through all of this, we haven't scaled the team massively.  We have 18 engineers (including myself) and 49 people at the company in total (as of October 2019).  Efficiency has been the name of the game so far, and I'm proud of what I've been able to accomplish with a small team and limited capital.

## PipelineDeals - VP engineering - 2006 to late 2016

* Built [PipelineDeals][pld] with cofounders from idea to successful bootstrapped SaaS app generating millions in revenue.  Is employee #1.
* Hired and Manages 3 remote teams of awesome software engineers.
* [Ensures the culture is strong and vibrant](https://medium.com/@gammons/4-awesome-ways-to-level-up-your-dev-team-32ab43f90678#.z6bh97clv), even though we are all remote.  Developer happiness and productivity are my primary concerns, while at the same time keeping accountability with the business side.
* [Crafted + continually hones][scrum] software delivery process to ensure high quality and tight collaboration.  Strives to keep process minimal.
* Manages a large production infrastructure in AWS, overseeing 50+ instances.  Implemented best-in-class practices to ensure speed, scalability, and uptime.   Achieved 99.999% uptime in 2015.  Has kept infrastructure costs well below [SaaS averages][saas] by strategic use + planning of reserved instances.

---

# Projects


## Ultradeck

![](images/ultradeck.png)

Built my own SaaS, called [Ultradeck](https://ultradeck.co).  Ultradeck was a developer-focused app to quicly create beautiful slides.

It did not get traction, but I learned a ton about product development.

While Ultradeck is no longer online, the [storybook](https://stories.ultradeck.co) still is.  The storybook gives you an idea of the breadth of the app.

I intend to open-source almost all of Ultradeck, starting with a [stripped-down version of the frontend](https://github.com/gammons/ultradeck-frontend) that communicates via a go-based binary to drive the slides.

**Utilized the following tech:**

* React via create-react-app
* Many custom markdown processing libraries
* Typescript
* Rails api-only backend
* Redis for websocket management / realtime
* Mysql

## Ultralist

![](images/ultralist.png)

[Ultralist][ultralist] is an [open source](https://github.com/ultralist) command-line task management app written in Go.

* Can be installed using Homebrew via `brew install ultralist`.
* The web view is a single-page app that automatically updates via a websocket connection.

I was intending to launch Ultralist as a side project that generates revenue. However, for me the tech is always more fun to do than the marketing.

**Utilizes the following tech:**

* Go - for the `ultralist` binary
* websockets for [realtime communication](https://github.com/ultralist/ultralist-websockets) between browser and binary
* Redis for websocket communication
* Rails api-only backend
* Mysql
* React via create-react-app for [the frontend](https://github.com/ultralist/ultralist-frontend)
* Progressive web app fundamentals
* material-ui for the CSS / interface

### 12inch.reviews

![](images/12inch.png)

[12inch.reviews](https://12inch.reviews) is a mash-up of [Pitchfork](https://pitchfork.com) reviews and [Spotify](https://spotify.com)'s web playback SDK, allowing you to quickly search for great music, and play it right on the website.

**Utilizes the following tech:**

* React
* Tailwind CSS
* Netlify lambda functions for access token management
* No backend!

## demo-cli

![](images/demo-cli.png)

Created a [simple library](https://demo-cli.dev) to show terminal-based demos in the browser.  Used in the marketing site for [Ultralist](https://ultralist.io).

## fake_arel

[fake_arel][fa] is a gem I wrote in 2010 that allowed developers to use Rails 3 query syntax in Rails 2.  It accomplished this by clever use of named scopes.

* We used this in production at PipelineDeals for a year or so while we refactored our app and readied it for Rails 3.
* Worked as advertised, as we were able to drop out fake_arel and begin using Rails 3 arel seamlessly.
* fake_arel was featured on the [Ruby5 podcast][r5] in 2010.

[ck]: https://convertkit.com
[pld]: https://www.pipelinedeals.com
[ultralist]: https://ultralist.io
[saas]: http://www.forentrepreneurs.com/2015-saas-survey-part-2
[scrum]: https://medium.com/cto-school/ditching-scrum-for-kanban-the-best-decision-we-ve-made-as-a-team-cd1167014a6f#.u93fsg4qx
[fa]: https://github.com/gammons/fake_arel
[r5]: https://ruby5.codeschool.com/episodes/99-episode-97-july-27-2010
