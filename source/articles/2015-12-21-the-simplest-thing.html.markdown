---
title: The simplest thing you can do to not violate the first principle of Agile
date: 2015-12-21 19:23 UTC
tags: software, process
cover: agile.png
page: blog
---

> **Individuals and interactions over processes and tools.**

Why?  Because the first principle of the Agile Manifesto is *so easy* to break.  We broke it big time and learned a lot when fixing it.

Tools like Jira seduce you into building a mammoth process that is convoluted and hard to convey to your team.  You get blinded by the allure of super-sweet metrics and charts.  And so the thought goes:  "We'll know our burndown rate and velocity, and it will all be on this pretty graph, and we'll put it up on the wall TV, and we shall revel in our newfound measurements!  Everyone will be on the same page then."

So you set up a wild and crazy workflow process, implement it for your team, and wait for those charts to just look freaking awesome on your wall TV.

But, that doesn't actually happen.  How do I know?  We traversed this path as a team.  It was a path that led to unhappiness.

## Slimming down the processes and tools

We were heavy Jira users for about 2 years.  Jira's a great tool for someone, but it turned out to be a very bad tool for us.  All the developers hated it.  Our PM didn't trust it.  It was slow and enterprisey feeling.

**There were bugs in the process.**  Developers and the PM consistently got tickets "stuck" in a state where they could not move them without an administrator's help.   Tickets would consistently fail to automatically move based upon some external stimuli.   Every month, we'd have to groom Jira to ensure tickets were in the right state, because we couldn't trust the system.

**We were never able to actually reconcile stories and tasks**  The PM really wanted to see stories moving across rather than tasks.  Because of how Jira is architected, we needed a totally separate workflow and boards for stories vs tasks.  Therefore, we'd consistently be in states where all the tasks were completed but the story was not.  This lead to a lot of consternation and mistrust of the tool.  Each morning before standups, I would have to "reconcile" the stories to match the task states daily.  Yes, I attempted to use some automations here but my automations had bugs as well.

We limped along like this for almost 2 years.  Jira followed us from our [transition from Scrum to Kanban][1].  I would consistently hear from the engineers that Jira was the bane of their existence.  The PM also hated it because he couldn't figure out the status of a story.  So here we had a tool that didn't function well and *nobody* was getting a benefit from.  It was time for a change.

### Moving foward

Finally fed up with all of this, I called everyone into a room and we decided to do a hard reset.  I did a lot of research, talking with team leads, the PM, and the VP of product.  We decided to strip everything down to the studs and **only add enough tooling to get the job done.**

* The board is imperative to using kanban and understanding the state of a story's development
* Because we're a remote team, we need an 'online' board.

But that's all we needed.  Anything more and we were afraid it would be overkill and start to introduce the same warts that our previous tool and process had.

**We decided to use Trello for our board.** Why trello?  Because it was the lightest-weight tool we could find that met our criteria.  Everyone understood it, and there was no heavy-duty "workflow" to get riddled with bugs.  It was like a breath of fresh air compared to the much more draconian Jira.

## Favoring individuals and interactions

Trello doesn't have a way of measuring velocity automatically.  We factored this in when moving, but came to an interesting realization about "agile metrics" in general.

**We decided to ditch the "agile metrics" and favor overcommunication instead.**  We lost Jira's charts and metrics, but given the bugs in our process, those never reflected reality anyways.   Also, I didn't know who the metrics were for.  Were they for me?  Our PM?  Our CEO?  Not really. What I care about is fostering a happy, productive team.  Our PM cares about shipping high quality software on time.  Our CEO cares about the company being successful as a whole.

Perhaps these metrics are there to ensure your developers are actually working.  Maybe I am a minority, but **I trust my engineers**.  They are a bunch of hard working, super smart folks.  The proof of their awesomeness is in the list of stuff they have shipped in the last 12 months.  [And that's even with having Investment Time every friday][2].

**Substitute knowing your velocity for just having a conversation.**  I don't know my team's velocity.   Instead, I have conversations with the team leads and the PM to ensure a project is going to be delivered on time.  If it isn't, we have a conversation about why not, and then we *overcommunicate that to the rest of the company*.

It's not only about project updates.  We'll communicate *everything*:  Technical challenges we overcame, who stayed up late, who's crushing it.  Also, we'll talk about not so awesome stuff as well.  We'll talk about the blip of downtime or the elevated error rates we saw + fixed.  I'll use paragraphs rather than charts.

These types of updates are so much better than just saying "our team's velocity is 53, which is 4 points more than last week!"  If that's your update, what happens when the velocity tanks?  You'll get a lot of funny looks.   Even if your update does include more context than the number, everyone's going to be focusing on the number rather than the story.  Focus on the story instead.

There are plenty of "Agile" tools and metrics out there.  Beware - hey can get away from you, at the cost of your team's happiness.  Tools like Jira make it *amazingly easy* to break the first priniple of Agile.

Keep it simple. Have conversations. Write paragraphs. Overcommunicate.  Don't let the tool replace those.

