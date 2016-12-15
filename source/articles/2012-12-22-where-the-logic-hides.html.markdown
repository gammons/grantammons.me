---
title: Where the logic hides in Rails apps
date: 2012-12-22 11:05 UTC
tags:
  - architecture
  - rails
comments: true
---

DHH recently authored a [SVN blog post](http://37signals.com/svn/posts/3372-put-chubby-models-on-a-diet-with-concerns) that advocated breaking up fat models into separate mixins that would live in a new directory in the rails structure, app/concerns.

He made it clear that breaking up domain logic into concerns will make code easier to work with and understand.   He is clearly staging that we can and should be using rails to dictate the architecture of our application.

Anyone who has worked on a sufficiently complex application, however, knows that readability and understandability is king.  Writing code that the next developer can easily reason about will always win in the long term.

While it is true that using modules will reduce the lines of code in a class, the it does not reduce the cognative workload to understand the class's internal api.
<!--more-->

### Rails still encourages business logic to live in the depths of your ActiveRecord models


ActiveRecord models inherently violate the Single Responsibility Principle, because they are in charge of many, many things:

 * Persistence
 * Validation
 * Associations
 * Life cycle hooks
 * ...and so much more!

In addition we are also encouraged to put the application's business logic in the model as well!

Imagine a very simple use case.

You manage a contact list application.  Imagine that when you create a new contact, the application is supposed to send an email to the contact.  There are many ways to solve this, but rails would encourage you to place that logic into a callback or an observer.

Rails encourages you to put that type of business logic into the model.  So the controller probably looks something like this:

```ruby
class ContactsController < ApplicationController
  def create
    @contact = Contact.new(params[:contact])

    respond_to do |format|
      if @contact.save
        ...
      end
    end
  end
end
```

To an outside observer, it is not entirely clear that an email will be sent.  I can see that the contact will be saved to the database (maybe), but the other intent, the email delivery, is obfuscated.

In order to see that business logic in action, I must dive into the model:

```ruby
class Contact < ActiveRecord::Base
  after_create :send_welcome_email

  private

  def send_welcome_email
    UserMailer.welcome_email(self).deliver
  end
end
```

It is bad enough that `@contact.save` now has triple duty:

 * It validates
 * It persists the contact model
 * It runs business logic injected into a callback

It is easy to imagine that in a sufficiently complex Rails application, this type of business logic is littered all over callbacks and observers.  The core value your application provides, therefore, is scattered all over the place.  In terms of
readability or maintainability, it is simply not a good enough solution to simply break off that business logic into a module, after the model gets large enough.

```ruby
class Contact < ActiveRecord::Base
  include SendWelcomeEmailUponCreate
end
```

Imagine you are a brand new developer on the team that supports this app.  You see the `@contact.save` call but now, the fact that it performs business logic is even harder to see, since the logic is placed in another module, somewhere in some other directory.

### Alternative - Use cases in their own place

The example provided above is simple enough to be covered by a [transaction script](http://martinfowler.com/eaaCatalog/transactionScript.html) that can handle creating the contact and executing the core business logic, all in one place.

```ruby
class CreatesContact
  def initialize(contact)
    @contact = contact
  end

  def create_contact!
    @contact.save
    UserMailer.contact_created_email.deliver
  end
end
```

This simple class has a very clear intent.  It saves a contact and runs business logic.  It is short, concise, easily testable, and easily extendible, if need be.

Perhaps this class lives in `app/use_cases`, where all of the primary use cases for your application live.

Imagine, later down the road, that the use case changes, and we need to send a mail _only if_ the contact has a certain flag set.

If we continue with the Rails architecture, we might end up here:

```ruby
class Contact < ActiveRecord::Base
  after_create :send_welcome_email, :if => :has_special_flag_set?
end
```

This is not ideal, however,  since we are continuing to extend a class that already has too many purposes.  Our `CreatesContact` class is a better place for that logic.

```ruby
class CreatesContact
  def initialize(contact)
    @contact = contact
  end

  def create_contact!
    @contact.save
    deliver_contact_created_email if should_send_contact_created_email?
  end
end
```

The intent is clear in the controller as well.  We are handing off to a class that knows all about creating contacts:

```ruby
class ContactsController < ApplicationController
  def create
    @contact = Contact.new(params[:contact])

    respond_to do |format|
      if @contact.valid?
        CreatesContact.new(@contact).create_contact!
        ...
      end
    end
  end
end
```

`CreatesContact` is simpler to test, easier to read and maintain, and simpler to extend, if need be.  It also divorces your application's core business logic from ActiveRecord.

### Conclusion

DHH preaches about keeping all business logic inside of the Rails application itself, and if things get too large, then modules is what you need.  At best it is an interesting argument, and at worst it is potentially disasterous for long-term
maintainability of an application.

All it takes is being part developing a large, reasonable complex [monolithic rails app](http://confreaks.com/videos/1125-gogaruco2012-mega-rails) for you to know that it is a very good idea to resist the swan song of putting your business logic into ActiveRecord models.

In fact, the ideas presented here are just one piece of the pie.  Your application should just happen to use rails as the web delivery mechanism.  Your tests should be [fast and outside of
rails](http://www.confreaks.com/videos/641-gogaruco2011-fast-rails-tests).  Your business logic should be outside of rails.  [Rails is a detail](http://www.confreaks.com/videos/759-rubymidwest2011-keynote-architecture-the-lost-years).  It does not define your application as a whole.

Continue the conversation on [hacker
news](http://news.ycombinator.com/item?id=4960232).
