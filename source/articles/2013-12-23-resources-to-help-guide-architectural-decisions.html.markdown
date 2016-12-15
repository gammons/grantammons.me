---
title: Resources to help guide architectural decisions in Rails apps
date: 2013-12-23 14:11 UTC
tags:
  - architecture
  - rails
comments: true
---

My [previous
post](http://gammons.github.com/architecture/2012/12/22/where-the-logic-hides/) outlined a trivial example where I refactored some basic, boring business logic into a
[service object](http://blog.codeclimate.com/blog/2012/10/17/7-ways-to-decompose-fat-activerecord-models/), or [transaction script](http://martinfowler.com/eaaCatalog/transactionScript.html) (depending on who you ask).

It set off a lot of debate on Twitter and <a href="http://news.ycombinator.com/item?id=4960232">Hacker news</a> about the topic.  I was quite surprised.  At the very least it means
that many others have felt the pain of having rails dictate your applications core architecture.

<!--more-->

## Signs that rails has dictated your core architecture

#### 1.  Upgrading major versions of rails is an enormous, painful process.

When Rails 4 drops, you should be able to upgrade your app on day one.  If you cannot, or it will require a large amount of refactoring  to get there, that is a smell that
your app is too reliant on the architecture given to you.

Plenty of people remember the painful process it was to upgrade a Rails 2.x app to Rails 3.  Hell, there was even a [gem released](https://github.com/rails/rails_upgrade) to
help guide the process!  That fact alone should be sending red flags up in your head.  Rails is a fantastic framework for RESTful, CRUDdy apps, but just like anything else,
things change.  Internal APIs change.  [The names of things you might have relied upon](http://m.onkey.org/active-record-query-interface) change.

#### 2.  All the use cases of your application are tied up in ActiveRecord models.

It is a good idea to start breaking up your application's business logic into service objects.  Service objects are essentially plain ol' ruby classes that can encapsulate a
process happening in your system.

Imagine a complex use case:

> In our CRM application, when we convert a lead to a deal, the lead will become a contact, we will send a lead converted email, and we will carry over the lead source and set that as the deal's source.  The email will only be sent, however, if the lead source has a dollar value set.

Where should that logic exist?  Should it exist in a Model?  Well, probably not.

There are many reasons that this interaction does not belong in a model:

*   This interaction involves many models.  If you have one ActiveRecord model instantiating and calling methods on *another* ActiveRecord model, then the first model probably knows too much!
*   It is unclear *which* model this interaction goes into.  Should it be the Deal?  Lead?  Arguments could be made for both.
*   We need to perform an external action (sending an email) based upon the state of an attribute in a __3rd__ model, the lead source.

Ok fine then, that logic should go in the controller!  Maybe that makes sense!

Let's implement the above use case.

```ruby
class LeadsController < ActionController
  def convert
    @lead = Lead.find params[:id]
    @lead_source = @lead.lead_source
    @deal = Deal.create(name: @lead.name, source: @lead_source, lead: @lead)
    @lead.touch(:converted_at)
    @lead.update_attribute(deal_id: @deal.id)
    UserMailer.lead_converted_email(@lead, @deal).deliver if @lead_source.value.present?

    respond_to ...
  end
end
```

Now you could argue that this is fine.  All of the logic is encapsulated into the controller.  However everyone knows that [you should keep your controllers
skinny](http://weblog.jamisbuck.org/2006/10/18/skinny-controller-fat-model).

Furthermore the above logic is in a place that is difficult to test.  You need to bring in the full rails stack in order to test this code, which makes testing slow.

A good alternative is a [service object](http://blog.codeclimate.com/blog/2012/10/17/7-ways-to-decompose-fat-activerecord-models/) whose job is solely to perform the convert
action.

```ruby
class ConvertLead
  def initialize(lead, lead_source)
    @lead, @lead_source = lead, lead_source
  end

  def convert!
    @deal = Deal.create(name: @lead.name, source: @lead_source, lead: @lead)
    @lead.touch(:converted_at)
    @lead.update_attribute(deal_id: @deal.id)
    send_lead_converted_email if @lead_source.has_value?
  end

  private

  def send_lead_converted_email
    UserMailer....deliver
  end
end
```

Since we have extracted this logic outside of rails, we can _test it in isolation_, which means we can __test it fast__, which brings me to my next point:

#### 3.  Your tests are slow, and you are testing your database too much

If you have tests that are reliant on the state of your database, that is a sign that you are not testing business logic, you are testing your database.

    expect { Deal.convert! }.to change { Lead.count }.by(1)

Trust me, __your database works__.  It will happily persist objects all the live long day.  It should _not_ be used as an intermediary to testing your business logic.

Going back to our example with the controller, testing that is a much easier process.  All we need to do is assert that we have handed control to our service object:

```ruby
describe LeadsController, "#convert" do
  it "hands control to our service object" do
    convert_lead = stub
    convert_lead.should_receive(:convert_lead!)
    ConvertLead.should_receive(:new).with(lead, lead_source).and_return(convert_lead)
    put :convert
  end
end
```

All we need to assert is that the message got there, with the correct args.  `ConvertLead` is tested in isolation, outside of Rails.

#### Resources that can help

There are plenty of resources around learning software architecture.

#### Conference Presentations

*   First and foremost,  watch this presentation by Uncle Bob:  [Architecture:  the lost years](http://confreaks.com/videos/759-rubymidwest2011-keynote-architecture-the-lost-years).  He give an eye-opening talk about where Rails should fit in your application.  (hint, it's not front and center!)
*   Then watch Corey Haines on [fast tests](http://www.confreaks.com/videos/641-gogaruco2011-fast-rails-tests).
*   [SOLID Ruby by Jim Weirich](http://confreaks.com/videos/185-rubyconf2009-solid-ruby)
*   [SOLID object oriented design by Sandi Metz](http://confreaks.com/videos/240-goruco2009-solid-object-oriented-design)

#### Screencasts

*   Uncle Bob hosts the amazing (but somewhat pricey) [screencasts about software development](http://www.cleancoders.com/).  Uncle bob dives into function naming, how long a
class or function should be, TDD, and the [SOLID principles](http://en.wikipedia.org/wiki/SOLID_(object-oriented_design) in depth.
*   [Gary Bernhardt](https://twitter.com/garybernhardt) creates the [Destroy All Software screencasts](https://www.destroyallsoftware.com/screencasts) which is an __excellent__ resource about testing, fast tests, TDD, and figuring out where logic should exist.
*   [Ryan Bates](http://railscasts.com) recently touched on the topic of [service objects](http://railscasts.com/episodes/398-service-objects).

#### Books

*   [Practical Object Oriented Design in Ruby](http://www.amazon.com/Practical-Object-Oriented-Design-Ruby-Addison-Wesley/dp/0321721330/ref=la_B0097WWH62_1_1?ie=UTF8&qid=1356370297&sr=1-1) by [Sandi Metz](http://sandimetz.com/)
*   [Rails as she is spoke](http://railsoopbook.com/) by [Giles Bowkett](http://gilesbowkett.blogspot.com/)
*   [Clean Ruby](http://clean-ruby.com/) by [Jim Gay](http://saturnflyer.com/blog/)
*   [Object on Rails](http://objectsonrails.com/) by [Avdi Grimm](http://about.avdi.org/)

#### Blogs and blog posts

*   The [8th light blog](http://blog.8thlight.com/uncle-bob/2012/08/13/the-clean-architecture.html) is an excellent starting point for learning about architecture.
*   [Use Rails until it hurts](http://evan.tiggerpalace.com/articles/2012/11/21/use-rails-until-it-hurts/)
*   [Making Uncle Bob happy](http://petelacey.tumblr.com/post/32626547077/making-uncle-bob-happy) is a very interesting post about a company that is utilizing a more modular
application architecture.  They claim fast tests, and the ability to switch from Rails to Sinatra very easily (not that that's useful, but it is the principle that counts)
*   [How modules can make code difficult to read](https://gist.github.com/4172391) by [Ryan Bates](http://railscasts.com/)
*   The [code climate blog](http://blog.codeclimate.com) is an excellent resource in general, for architecture and design.
*   [7 ways to decompose fat activerecord models](http://blog.codeclimate.com/blog/2012/10/17/7-ways-to-decompose-fat-activerecord-models/)

#### Github repos

*   [A Web Application for Avdi and Uncle Bob, by Andrew Greenberg](https://github.com/wizardwerdna/avdi)
*   [A Rails app called Raidit](https://github.com/jasonroelofs/raidit) has an interesting design.
*   [A rails app called Guru Watch](https://github.com/qertoip/guru_watch) has an interesting design as well.  (Notice the [use_cases](https://github.com/qertoip/guru_watch/tree/master/app/use_cases) directory!)
