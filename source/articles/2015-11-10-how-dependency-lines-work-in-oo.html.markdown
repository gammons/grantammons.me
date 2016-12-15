---
title: How dependency lines work in object-oriented design
date: 2015-11-10 13:01 UTC
tags:
  - software
  - architecture
comments: true
---

When you look at an object dependency graph, it's not 100% clear how to read it.  When one object points to another,
what does that mean exactly?

An object is said to depend on another object in the following scenarios:

1. When an object knows the name of another object
2. When an object knows the name of a method of another object, and knows the arguments that method takes

The first is quite easy to recognize and if you have that first dependency level, you implicitly have the second.  If at
all possible, you want to strive towards the second point.

<!--more-->

Below is an obvious example of a class having a name dependency on another object.  In this case a `Car` object has a
dependency on an `Engine` object.

```ruby
class Car
  def initialize
    @engine = Engine.new
    @engine.start
  end
end

class Engine
  def start
    ...
  end
end
```

If we looked at this relationship using UML, it would look something like this.

![](car_dependency-1.png)

In UML, the arrows always point in the direction of the dependency.  The particular example above illustrates that a
`Car` depends on an `Engine`.

This means that if, sometime in the future, the `Engine` class needs to change, `Car` may need to change with it.  This
is why you need to take care to minimize the dependencies between objects.

If one object knows the name of another object, the coupling is absolute.  There simply isn't a tighter binding.  If one
object must require another object in some fashion, you can reduce the tightness of this coupling by binding to the
object's message, rather than than the name.

If at all possible, you should always strive for the second type of coupling, which is to bind to a *message*, rather
than a *class*.  This is illustrated below:

```ruby
class Car
  def initialize(engine)
    @engine = engine
    engine.start
  end
end

class Engine
  def start
    ...
  end
end

Car.new(GasEngine.new)
```

This is an example of a more loosely coupled binding, and is preferable to the name-based tight coupling in many ways.
Essentially, you have removed the hard coupling to another class, and instead have a coupling to an *interface*.   You
can then pass in anything that implements the `start` method.

1.  This code is more flexible.  I am now able to pass anything into the `new` method of car.  If, for instance, another
type of engine was invented, (say a `BatteryEngine`), I am free to pass this into `Car`, provided that `BatteryEngine`
implements the method `start`.
2.  This code is easier to test.  If `Engine` was just the tip of the iceburg, and needed to reach out to a 3rd party
api, then it would be easy to stub out `Engine` for testing.

This is the crux of *dependency injection*.  You are *injecting* the Engine dependency into `Car`.

If we were to draw a new UML diagram, it would look something like this:

![](/images/car_dependency_2-1.png)

This is a better scenario mainly because you want to *program to an interface, not to an implementation*.   In ruby,
there are no hard interfaces.  The interface here is implicit.  The car object is implicitly expecting the engine object
we pass in to implement `start`.

This is one of the core tenets of reusable object-oriented design.

## Applying this to a rails app

At a very high level, you want your dependency lines to be pointing in the same direction, away from Rails, towards your
business logic.  You *don't* want your business logic to be calling Rails-y objects.

So, for instance, it's perfectly fine for your a Rails controller to call a class that invokes business logic.  Imagine
if you have a simple policy object that determines whether or not a user has sufficient privileges to post:

```ruby
class PostsController < ApplicationController
  def create
    if PostingPolicy.new(user).can_create_post?
      flash[:notice] = "Post has been saved."
    else
      render status: UnprocessableEntity
    end
  end
end
```

And then, somewhere else, perhaps in `app/lib`, you have `PostingPolicy` defined:

```ruby
class PostingPolicy
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def can_create_post?
    @user.has_post_access? || @user.is_admin?
  end
end
```

It's perfectly acceptable for your Rails-y objects to call up your business logic.  In the case above, `PostsController`
is depends on `PostingPolicy`, and that is just fine.

Here we are passing in a `User` object to `PostingPolicy`, and we have a 2nd-order dependency.  In other words,
`PostingPolicy` depends on the `User` **interface**, not the object itself.

Where we get into trouble, however, is when your business logic uses Rails objects directly.

Imagine we have a `PostingPolicy` as such:

```ruby
class PostingPolicy
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def can_create_post?
    user.has_post_access? || user.is_admin?
    User.increment!(:post_attempts)
  end
end
```

Do you see the problematic line?  If you said the one with `UserMailer`, you are correct.  Here, `PostingPolicy` is calling a Rails model.  In this case, your business logic is starting to get tied up in Rails-y
things.  Your business logic is pointing _back_ to the Rails framework, and _depending_ on Rails.  __This is what is to be avoided.__

In this particular case, it would be easy enough just to throw the `User.increment!` back into the controller.

```ruby
class PostsController < ApplicationController
  def create
    User.increment!(:post_attempts)
    if PostingPolicy.new(user).can_create_post?
      flash[:notice] = "Post has been saved."
    else
      render status: UnprocessableEntity
    end
  end
end
```

That way, the `increment!` call is still within the Rails land, and your business logic does not have a dependency on Rails:

```ruby
class PostingPolicy
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def can_create_post?
    user.has_post_access? || user.is_admin?
  end
end
```

"But wait!" you say, "isn't `user' a rails model, and therefore the dependency lines are still pointing in the wrong direction?`

And the answer is, __no!__.  But why?  Well, I'll tell you why.

`PostingPolicy` is depending on an __object__ that has the following methods: `_has_post_access?` and `is_admin?`.  This object could be _any_ type.  It could be a mock object in a test.  It could be an instance of a plain ol' ruby object that has those methods.  Or, it could be a `User` class that inherits from `ActiveRecord::Base`.

The point is, `PostingPolicy` is dependent on being passed in an object that implements those methods.  It is dependent on an `interface`.  Much like our `Engine` example above, we're passing in the object we need, rather than naming it directly.  This is how you keep your business logic free and clear of being dependent on your framework.  It also makes your code easier to test!
