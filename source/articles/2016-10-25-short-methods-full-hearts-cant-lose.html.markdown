---
title: Short methods, full hearts, cant lose
date: 2016-10-25 11:09 UTC
tags: cleancode, seniordevchops
---

![](/images/shortMethods.jpg)

If there's one rule that really makes all the difference in terms of code readability, it's *keeping your method sizes small*.  Your present and future teammates will thank you for it.

What do I mean by *small*?  Well, according to [Sandi Metz][metz] and [Uncle Bob][bob], methods should generally be [**5 lines or less**][fivelines].  You read that right.  If you need more lines, then usually it's time to split that function up.

Writing small methods forces your hand to name things descriptively, which greatly helps with the readability of your code.  Your methods will also generally tend to *do one thing*.  That's what you're aiming for when creating new functions.

Now, should you follow this rule absolutely 100% of the time?  Of course not!  The "5 lines" piece is mainly to keep you in the right mindset when writing code.  You want your methods to be as small as you can possibly make them.  The goal is well-factored code.  And why do you want well-factored code?  Because you don't want your teammates place a bounty on your head 6 months from now, when they have to extend and/or maintain your code.  You want them to *easily* and *quickly* understand what is going on with the code you write.

Let's go through a refactor session of some real-world code.  For this example I've picked the [Discourse][discourse] project, which is open-source online forum software.  This code is the `password_reset` function in the `users_controller`, and it clocks in at a whopping 39 lines!  This function is way too long, and any developer looking at it would have a hard time figuring out what is going on.

```ruby
  def password_reset
    expires_now

    if EmailToken.valid_token_format?(params[:token])
      if request.put?
        @user = EmailToken.confirm(params[:token])
      else
        email_token = EmailToken.confirmable(params[:token])
        @user = email_token.try(:user)
      end

      if @user
        session["password-#{params[:token]}"] = @user.id
      else
        user_id = session["password-#{params[:token]}"]
        @user = User.find(user_id) if user_id
      end
    else
      @invalid_token = true
    end

    if !@user
      @error = I18n.t('password_reset.no_token')
    elsif request.put?
      @invalid_password = params[:password].blank? || params[:password].length > User.max_password_length

      if @invalid_password
        @user.errors.add(:password, :invalid)
      else
        @user.password = params[:password]
        @user.password_required!
        @user.auth_token = nil
        if @user.save
          Invite.invalidate_for_email(@user.email) # invite link can't be used to log in anymore
          session["password-#{params[:token]}"] = nil
          logon_after_password_reset
        end
      end
    end
    render layout: 'no_ember'
  end
```

The first thing you'll notice is the large peaks and valleys of the `if` statements, and in fact that's where we'll start.  The first `if` deals with trying to extract a user from a token.  So, I think a descriptive name of this functionality would be `get_user_from_token`.

```ruby
  def password_reset
    expires_now
    get_user_from_token

    if !@user
      @error = I18n.t('password_reset.no_token')
    elsif request.put?
      @invalid_password = params[:password].blank? || params[:password].length > User.max_password_length

      if @invalid_password
        @user.errors.add(:password, :invalid)
      else
        @user.password = params[:password]
        @user.password_required!
        @user.auth_token = nil
        if @user.save
          Invite.invalidate_for_email(@user.email) # invite link can't be used to log in anymore
          session["password-#{params[:token]}"] = nil
          logon_after_password_reset
        end
      end
    end
    render layout: 'no_ember'
  end
```

```ruby
  def get_user_from_token
    if EmailToken.valid_token_format?(params[:token])
      if request.put?
        @user = EmailToken.confirm(params[:token])
      else
        email_token = EmailToken.confirmable(params[:token])
        @user = email_token.try(:user)
      end

      if @user
        session["password-#{params[:token]}"] = @user.id
      else
        user_id = session["password-#{params[:token]}"]
        @user = User.find(user_id) if user_id
      end
    else
      @invalid_token = true
    end
  end
```

And :boom: just like that, our `password_reset` function went from **39** lines to **22**!  Progress is being made!  The method is also *more readable*.  If you need to extend the functionality of getting a user from a token, you can study that function.  If you *don't* care about that, then you're free to skip it.  Less to grok, less to keep in your brain.  It's win/win.

But here's the thing, we can actually keep going.  Instead of a single 39 line function, we now 2 functions that are still pretty large in size, but more importantly they are not as readable as they can be.

Back in `password_reset`, I think we can extract the logic that actually changes a user's password:

```ruby
  def password_reset
    expires_now
    get_user_from_token

    if !@user
      @error = I18n.t('password_reset.no_token')
    elsif request.put?
      @invalid_password = params[:password].blank? || params[:password].length > User.max_password_length

      if @invalid_password
        @user.errors.add(:password, :invalid)
      else
        perform_password_reset
      end
    end
    render layout: 'no_ember'
  end
```

```ruby
  def perform_password_reset
    @user.password = params[:password]
    @user.password_required!
    @user.auth_token = nil
    if @user.save
      Invite.invalidate_for_email(@user.email) # invite link can't be used to log in anymore
      session["password-#{params[:token]}"] = nil
      logon_after_password_reset
    end
  end
```

Awesome.  Now our `password_reset` function feels more like a method we can be proud of.  It's now 15 lines, but more importantly it's readling *more like english* and *less like code*.

Can we go further?  Absolutely!  While our new methods certainly make `password_reset` smaller, there's still some logic we can extract out into new methods.  Let's take a look at the method we just created, `get_user_from_token`.

```ruby
  def get_user_from_token
    if EmailToken.valid_token_format?(params[:token])
      if request.put?
        @user = EmailToken.confirm(params[:token])
      else
        email_token = EmailToken.confirmable(params[:token])
        @user = email_token.try(:user)
      end

      if @user
        session["password-#{params[:token]}"] = @user.id
      else
        user_id = session["password-#{params[:token]}"]
        @user = User.find(user_id) if user_id
      end
    else
      @invalid_token = true
    end
  end
```

It's 17 lines and does a lot of things.  So first let's take advantage of Ruby's brevity and return early, rather than using a giant `if` statement:

```ruby
  def get_user_from_token
    @invalid_token = true and return unless EmailToken.valid_token_format?(params[:token])

    if request.put?
      @user = EmailToken.confirm(params[:token])
    else
      email_token = EmailToken.confirmable(params[:token])
      @user = email_token.try(:user)
    end

    if @user
      session["password-#{params[:token]}"] = @user.id
    else
      user_id = session["password-#{params[:token]}"]
      @user = User.find(user_id) if user_id
    end
  end
```

Now it's 15 lines.  Next, let's look at the first `if` block that has to deal with assigning `@user`.  Can we make this a bit clearer?  What if we did something like this:

```ruby
    @user = if request.put?
      EmailToken.confirm(params[:token])
    else
      EmailToken.confirmable(params[:token]).try(:user)
    end
```

That's easier to undertand and it's shorter. And, it can be it's on function as well!

```ruby
  def get_user_from_token
    @invalid_token = true and return unless EmailToken.valid_token_format?(params[:token])

    @user = get_user_from_reqeust

    if @user
      session["password-#{params[:token]}"] = @user.id
    else
      user_id = session["password-#{params[:token]}"]
      @user = User.find(user_id) if user_id
    end
  end
```

```
  def get_user_from_request
    if request.put?
      EmailToken.confirm(params[:token])
    else
      EmailToken.confirmable(params[:token]).try(:user)
    end
  end
```

Finally, I think there's a bit more we can extract out of the `password_reset` function.  The code block in the `elsif request.put?` can be put in its own method as well:

```ruby
  def password_reset
    expires_now
    get_user_from_token

    if !@user
      @error = I18n.t('password_reset.no_token')
    elsif request.put?
      handle_password_put_request
    end
    render layout: 'no_ember'
  end
```

```ruby
  def handle_password_put_request
    @invalid_password = params[:password].blank? || params[:password].length > User.max_password_length

    if @invalid_password
      @user.errors.add(:password, :invalid)
    else
      perform_password_reset
    end
  end
```

And so there you have it,  we've refactored `password_reset` from 39 lines down to 9!

Could we go further?  You know, we probably could.  However, I think at this point the function is quite readable as it stands, and does not need more refactoring.  There is a point where you can introduce too much [*indirection*][indirection], where there are so many methods that it's hard to follow the string of logic.  It's a game of judgement, where readability trumps all.

In short - much like Kramer [slicing thin meats][meats], you want *thin functions*.  So thin, the flavor has nowhere to hide.  Keep this in mind and your teammates will thank you!

![](/images/meats.png)

[meats]: https://www.youtube.com/watch?v=wcFZIj96LwY
[indirection]: https://en.wikipedia.org/wiki/Indirection
[fivelines]: https://gist.github.com/PenneyGadget/879c53077621808adff2
[metz]: http://www.sandimetz.com/
[bob]: https://cleancoders.com/episode/clean-code-episode-3/show
[discourse]: https://github.com/discourse/discourse

