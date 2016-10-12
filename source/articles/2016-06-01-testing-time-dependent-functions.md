---
title: Testing time-dependent functions
date: 2016-06-01 10:03 UTC
tags: testing
cover: clock.jpg
page: blog
---

Recently I started a weekend project called [Todolist](http://todolist.site), which is a little Go application for the command line that does simple task management.  Todolist is centered around due dates,  and I needed a good way to unit test my code.  So the question was, how do I test functions with dates in Go?

Well, in Ruby the answer is simple.  You either grab [Timecop](https://github.com/travisjeffery/timecop) or drag in [ActiveSupport's TimeHelpers](http://api.rubyonrails.org/classes/ActiveSupport/Testing/TimeHelpers.html) and use `travel_to` to mock up the date you need to be at.

But you have to ask yourself, is this the best way to test time-dependent code?  By mocking a global variable?

Consider the following (very contrived) function:

```ruby
class WeekLibrary
  def is_weekday?
    ![0,6].include?(Date.today.wday)
  end
end
```

The above function, while easy to reason about, is actually very hard to test.  If I were to test this I'd probably do something like this:

```ruby
require "minitest/autorun"
require "timecop"

class TestWeekLibrary < Minitest::Test
  def test_is_weekday_when_weekday
    monday = Time.local(2016,5,30)
    wednesday = Time.local(2016,6,1)
    friday = Time.local(2016,6,3)

    [monday, wednesday, friday].each do |day|
      Timecop.freeze(day) do
        assert_equal true, WeekLibrary.new.is_weekday?
      end
    end
  end

  def test_is_weekday_when_not_weekday
    saturday = Time.local(2016,6,4)
    sunday = Time.local(2016,6,5)

    [saturday, sunday].each do |day|
      Timecop.freeze(day) do
        assert_equal false, WeekLibrary.new.is_weekday?
      end
    end
  end
end
```

The main issue here is that I must mock the `Time` and `Date` classes in order to test my function.  The reason is because my function is fully dependent on today's date.   It is a hard dependency on a global state (in this case `Date.today`).  The output of my function will change based upon the day I run my test!  So I *must* mock `Date.today`.  Right?  Right!?

Well, maybe not!  If we treat today's date as a *dependency* then we can always *reverse* that dependency with good ol' [dependency injection](http://martinfowler.com/articles/dipInTheWild.html).  In this case, if we *inject* the date rather than depending on it, then the function instantly becomes much more testable:

```ruby
class WeekLibrary
  def is_weekday?(day = Date.today)
    ![0,6].include?(day.wday)
  end
end
```

Well huh, so the default here is still today's date, which is great for the usability of my class's API. But I can also *inject* a specific date, which is great for testing purposes. This completely eliminates the need for Timecop, `travel_to`, or what have you.

Another positive side effect is that my function is now much more generic.  Now, `is_weekday` will tell me if *any* date is a weekday, rather than *today's* date.  It has much more utility.

The tests are also much simpler. We have no need for a monkeypatching time library or any time traveling boilerplate:

```ruby
require "minitest/autorun"

class TestWeekLibrary < Minitest::Test
  def test_is_weekday_when_weekday
    monday = Time.local(2016,5,30)
    wednesday = Time.local(2016,6,1)
    friday = Time.local(2016,6,3)

    [monday, wednesday, friday].each do |day|
      assert_equal true, WeekLibrary.new.is_weekday?(day)
    end
  end

  def test_is_weekday_when_not_weekday
    saturday = Time.local(2016,6,4)
    sunday = Time.local(2016,6,5)

    assert_equal false, WeekLibrary.new.is_weekday?(saturday)
    assert_equal false, WeekLibrary.new.is_weekday?(sunday)
  end
end

```

So what's the TLDR?

**1. Functions that require comparisons to today's date are *dependent* on time.**

Today is variable.  As I write this, today is Wednesday.  But tomorrow, today will be Thursday!  The simple fact that time (purportedly) moves forward makes a function's output *variable* based upon when it is run.  This makes the function's [testability](http://googletesting.blogspot.com/2008/08/by-miko-hevery-so-you-decided-to.html) very difficult, and introduces a reliance on a global state.

While using libraries to fix the output of `Date.today` is handy, it's not the best solution.


**2. Use dependency injection to inject the comparison date rather than relying on today's date.**

If you find yourself relying on a time class in your function and are about to reach for a time mocking library like `travel_to`, try injecting the date into the function first.  There's a good chance your problem will be solved right there!
