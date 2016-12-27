---
title: "async/await:  The asynchronous code detangler"
date: 2016-12-22 19:51 UTC
tags: javascript
comments: true
---

In my previous post, we went through some examples of using promises to light up some balls.  It was fun.  And I showed how promises can really clean up asynchronous function calls.

But...

![](/images/morpheus.jpg)

Did you know that there is an *even easier* way of writing asynchronous code?  Using `async` and `await`, you can write asynchronous code in a very procedural, synchronous way.

We’ll continue where we left off with our Ball Lighter application and convert our promise-based solution to something that uses `async` and `await`, and we’ll compare and contrast the differences.

## What do I need to know before diving in?

Be sure you have a firm grasp on promises.  `await` relies on Promises to function, and you'll need to have a good understanding of how those work before continuing.

[I wrote an article on how to use promises](http://grantammons.me/2016/12/16/javascript-promises-made-easy/).  If you're a little shaky, start there.

## The quest for cleaner asynchronous code

If you remember, we had our Ball Lighter example with promises, and that would light up our balls sequentially, one after the other, with a 700ms delay in between:

<p data-height="550" data-theme-id="0" data-slug-hash="xRyMpK" data-default-tab="js,result" data-user="gammons" data-embed-version="2" data-pen-title="Promises" class="codepen">See the Pen <a href="http://codepen.io/gammons/pen/xRyMpK/">Promises</a> by Grant Ammons (<a href="http://codepen.io/gammons">@gammons</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="https://production-assets.codepen.io/assets/embed/ei.js"></script>

`lightBallsSequentially` looks pretty good, but wouldn't it be awesome if we could just "get rid of" the asynchronous-ness of it all, and just write the code in a more straightforward way?

I come from a Ruby background, where functions do not execute asynchrnously.  If I wrote `lightBallsSequentially` in Ruby, it might look something like this:

```ruby
def lightBallsSequentially()
  begin
    lightBall('one')
    lightBall('two')
    lightBall('three')
    lightBall('four')
  rescue Exception => e
    alert("Whoops, error was #{e.message}")
  end
end
```

That feels very straightforward.  Can we do it in Javascript?

The answer:  **Yup! Use `async` and `await!`** These are new(ish) concepts that are part of ES2016+, which now have [some major browser support](http://kangax.github.io/compat-table/es2016plus/#test-async_functions).

## `async` and `await` in detail

Let's start off with a super-simple example:

<p data-height="550" data-theme-id="0" data-slug-hash="rWgNRq" data-default-tab="js,result" data-user="gammons" data-embed-version="2" data-pen-title="async / await simple example" class="codepen">See the Pen <a href="http://codepen.io/gammons/pen/rWgNRq/">async / await simple example</a> by Grant Ammons (<a href="http://codepen.io/gammons">@gammons</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="https://production-assets.codepen.io/assets/embed/ei.js"></script>

Here you'll notice that when you run the `testAwait` function, You see "about to run asyncFn" followed by "Result is Bingo!" 1 second later.  It feels very procedural indeed.

`await` is the real star of the show here.  It will automatically wait for the asynchronous call to complete before moving onto the next statement.  Since `await` is promise-based, it is technically waiting for the promise to *be fulfilled* before moving onto the next statement.

In our example, `asyncFn` is already returning a promise, so we're all good.  But can `await` work *without* returning a promise?  Yup, it can!  `await` will *promisify* anything after it.  That is, it will wrap a value in a promise and resolve it immediately.  if If the result is already an instance of `Promise`, then it’s left alone.

`await` will then wait for the promise to be fulfilled, which means that either the `resolve` or `reject` functions have ran in the promise.  If the promise is resolved successfully.  Take a look below:

<p data-height="513" data-theme-id="0" data-slug-hash="YpbzKB" data-default-tab="js,result" data-user="gammons" data-embed-version="2" data-pen-title="Fun with async / await" class="codepen">See the Pen <a href="http://codepen.io/gammons/pen/YpbzKB/">Fun with async / await</a> by Grant Ammons (<a href="http://codepen.io/gammons">@gammons</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="https://production-assets.codepen.io/assets/embed/ei.js"></script>

One caveat here:  In order to use `await`, you must place `async` before the function defintion of the function using it.  That's why we have `async function testAwait()` at the top.

## Lighting up these balls using `async` and `await`

Onto the wonderful ball-lighting example.  Below, we see Ball Lighter running using `async` and `await`.

<p data-height="482" data-theme-id="0" data-slug-hash="gLyXWa" data-default-tab="js,result" data-user="gammons" data-embed-version="2" data-pen-title="Async / await version" class="codepen">See the Pen <a href="http://codepen.io/gammons/pen/gLyXWa/">Async / await version</a> by Grant Ammons (<a href="http://codepen.io/gammons">@gammons</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="https://production-assets.codepen.io/assets/embed/ei.js"></script>

The `lightBallsSequentially` function looks *very* nice indeed!

It's super easy to read - almost like a procedural language.  And really that’s the key thing: **async and await will make your code easier to read**.  And readability is the #1 thing you should be going for when writing code.

## Can I use `async` and `await` now?
In the words of Ned flanders:  The short answer is yes, with an if; long answer, no with a but.

As of July 2016, async/await are now in Stage 4, which means they are accepted into the ES2017 spec.  Some browsers (like Google Chrome and Firefox nightly) [already implement async/await natively](https://developers.google.com/web/fundamentals/getting-started/primers/async-functions).  However in most cases, you'll need a polyfill like Babel to ensure that your code can be run on all modern browsers.

# Conclusion

When I first started out writing a lot of asynchronous Javascript code, I was tearing my hair out trying to keep things clean and understandable.  Now, with async/await, my asynchronous code is much *much* nicer.  It's a lot easier for humans to read and understand, which is the whole point of this coding thing.
