---
title: "Learn promises via ridiculous examples"
date: 2016-12-16 12:21 UTC
tags:
  - Javascript
  - patterns
comments: true
---

_**Note**_: *while reading this article, you should listen to [Promises, Promises by Naked eyes.](https://www.youtube.com/watch?v=WBupia9oidU)*

Promises hold the **promise** (yup) that they will make your asynchronous code easier to work with.  They will help you avoid *callback hell* in a lot of situations, where you'd otherwise need to deeply nest code.

Promises are now native to all modern browsers, and the pattern is ubiquitous in the Javascript community.  So if you haven't taken the time to learn it yet, settle in and learn you Promises for great justice.

## Example 1:  Random numbers (but not too high)

Lots of calls in javascript are asynchronous.  That is, you must supply them with a callback function.  The best example of how promises work is to just dive in and *promisify* an asynchronous call.

Behold, a wild contrived asynchronous call appears!

```javascript
const getRandoNumButNotTooHigh = (cbFn) => {
  setTimeout(() => {
    const num = Math.random()
    if (num <= 0.8) {
      cbFn(null, num)
    } else {
      cbFn("Sorry, number was too damn high")
    }
  }, 200)
}
```

In this case, the asynchronous call is `getRandoNumButNotTooHigh`, whose only argument is a callback function that executes when it's done.  That callback function takes 2 arguments, `error` or `data`.  It generates a random float number between 0 and 1.  If the number is over 0.8, we return an error saying the number was too damn high.  Otherwise we return the number.  Also, I wrapped it all in a `setTimeout` because otherwise this example wouldn't make any sense.  So just roll with it.

We're calling `getRandoNumButNotTooHigh ` in a simple loop that instantiates the callback function and just logs the result.  Easy enough:

```javascript
for(let x = 0; x < 10; x++) {
  getRandoNumButNotTooHigh((err, num) => {
    if (err) {
      log("sorry, number was too damn high")
    } else {
      log(num)
    }
  })
}
```

Below, you can see this function actually running IRL.

<p data-height="553" data-theme-id="0" data-slug-hash="gLZrvM" data-default-tab="js,result" data-user="gammons" data-embed-version="2" data-pen-title="doAsyncCall" class="codepen">See the Pen <a href="http://codepen.io/gammons/pen/gLZrvM/">doAsyncCall</a> by Grant Ammons (<a href="http://codepen.io/gammons">@gammons</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="https://production-assets.codepen.io/assets/embed/ei.js"></script>

Ok.  Still with me? Great.  Next, I am going to rewrite `getRandoNumButNotTooHigh` to return an instance of `Promise`, and we'll see what that does:

```javascript
const getRandoNumButNotTooHigh = () => {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      const num = Math.random()
      if (num <= 0.8) {
        resolve(num)
      } else {
        reject("Sorry, number was too damn high")
      }
    }, 200)
  })
}
```

Alright.  So it's *slightly* different now.  Let's break it down.

* First, `getRandoNumButNotTooHigh` *no longer needs a callback function (`cbFn`) to be passed in*.  This is key, and we'll see how that's awesome in a minute when we call this function.
* Second, we're returning a `new Promise`.
* Third, the `Promise` instance takes 2 arguments, `resolve` and `reject`, which are functions that get called when the asynchronous function is done.  You'll notice that `resolve` is the happy path, and `reject` is the *sad panda path*. :panda_face:

**Calling a promise**

So how does this look when we call it?  Well, it looks freaking cool:

```javascript
for(let x = 0; x < 10; x++) {
  getRandoNumButNotTooHigh().then(num => {
    log(num)
  }).catch(err => {
    log("sorry, number was too damn high")
  })
}
```

And here you see *real benefit* of promises:  the calling function is easier to read!  Let's break the calling function down:

Inside the for loop we are executing `getRandoNumButNotTooHigh()` which returns the `Promise` object.  Once the promise resolves, it will either call `then` or `catch`.

* If `getRandoNumButNotTooHigh` executes `resolve`, then the promise will execute the `then` block.
* If `getRandoNumButNotTooHigh` executes `reject`, then the will execute the `catch` block.

Below is a working example of the code:

<p data-height="550" data-theme-id="0" data-slug-hash="zoyqjy" data-default-tab="js,result" data-user="gammons" data-embed-version="2" data-pen-title="doAsyncCall - NOW WITH PROMISES!!1!" class="codepen">See the Pen <a href="http://codepen.io/gammons/pen/zoyqjy/">doAsyncCall - NOW WITH PROMISES!!1!</a> by Grant Ammons (<a href="http://codepen.io/gammons">@gammons</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="https://production-assets.codepen.io/assets/embed/ei.js"></script>

## Promises returning promises

Are there other benefits to using promises?  You betcha!  There *are* other benefits that look *promising* (yup) as well!

See the thing is, promises always return promises.  Whatever you return in the `then` block of a promise *gets wrapped in a promise* that immediately resolves.  If you are already returning a promise, it will not wrap.

This has some pretty nifty IRL consequences, because you can chain `then` calls and avoid the dreaded [pyramid of doom](http://web.archive.org/web/20151209151711/http://tritarget.org/blog/2012/11/28/the-pyramid-of-doom-a-javascript-style-trap).

Check it out:

```javascript
for(let x = 0; x < 10; x++) {
  getRandoNumButNotTooHigh().then(num => {
    return num  // returns a number so it will be wrapped in a promise
  }).then(num => {
    return getRandoNumButNotTooHigh() // returns a promise already so no wrapping
  }).then(num => {
    return num * -1 // returns a number so will be wrapped in a promise
  }).then(num => {
    log(num) // returns null so will be wrapped in a promise
  }).catch(err => {
    log(err)
  })
}
```

This has the potential to flatten out a lot of deeply nested asynchronous calls.

## Example #2: Promise fun by lighting balls

Using promises, aysnchronous calls can be sequenced easily.  Since `then` is run *after* an asynchronous function is done, chaining `then` calls ensures that the asynchronous calls are sequentially run.

Since it's (currently) 'tis the season, we'll be lighting some balls to celebrate. So I present to you: **BALL LIGHTER.**

### Sequential ball lighting (the non-promise way)

First, we'll light some balls the non-promise way, and see where that takes us.  After that we'll use promises to light up those balls (and our hearts), and see the difference in the code.

So first, the unceremonious ball lighting without promises:

<p data-height="550" data-theme-id="0" data-slug-hash="jVeJMR" data-default-tab="js,result" data-user="gammons" data-embed-version="2" data-pen-title="Sequences without promises" class="codepen">See the Pen <a href="http://codepen.io/gammons/pen/jVeJMR/">Sequences without promises</a> by Grant Ammons (<a href="http://codepen.io/gammons">@gammons</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="https://production-assets.codepen.io/assets/embed/ei.js"></script>

Here's what you need to know about these balls:

First, there's a 700ms CSS3 transition which needs to run in order for the balls to light up smoothly.

```css
#circles > div {
  transition: all 0.7s;
}
```

So in order for that transition to run, we need to build in a 700ms delay after each ball is lit.  Here's our `lightBall` function:

```javascript
const lightBall = (id, cb) => {
  const el = document.getElementById(id)
  el.style.backgroundColor = "#FFEA85";
  el.style.boxShadow = "0px 0px 10px 0px #FFEA85";
  setTimeout(() => { cb() }, 700)
}
```

You'll notice we pass in a callback function `cb` at the end.  Then, we run a `setTimeout` to execute that callback after 700ms.

Putting it all together, we have a function called `lightBallsSequentially`:

```javascript
const lightBallsSequentially = () => {
  lightBall('one', () => {
    lightBall('two', () => {
      lightBall('three', () => {
        lightBall('four', () => {
          console.log("done!")
        })
      })
    })
  })
}
```

Why?  Because in order to light the balls one at a time, we need rely on the `lightBall` callback function to be executed.  In that callback, we can then light the next ball sequentially.  What we have here is a textbook example of the Pyramid of Doom.

Here's what a promise-ified `lightBall` looks like:

```javascript
const lightBall = (id) => {
  return new Promise((resolve, reject) => {
    const el = document.getElementById(id)
    if (!el) {
      reject(`Could not find element with id ${id}`)
    }
    el.style.backgroundColor = "#FFEA85";
    el.style.boxShadow = "0px 0px 10px 0px #FFEA85";
    setTimeout(() => { resolve() }, 700)
  })
}
```

Notice we don't need to pass in a callback.  Instead we're returning a `new Promise`.  A promise takes 2 arguments:  `resolve` and `reject` which are functions.  `lightBall` calls `resolve()` after 700ms.  This "resolves" the promise.

If we passed in an id that we could not find, the promise will run `reject` with the error message.

**That's great, but how do I use this?**

Now you can call `lightBall` and use the new awesome promise syntax:

```javascript
lightBall('one').then(() => {
  console.log("700ms passed, the ball is done lighting!")
}).catch(err => {
  console.log("Oh snap, something happened:", err)
})
```

When the `resolve()` function runs, the caller of the promise will run `then()`.  Similarly, if `reject()` was called, the `catch` block will run.

And now, with the promises in place, we can run our ball lighting sequence *without* the pyramid of doom!

```javascript
lightBall('one').then(() => {
  return lightBall('two')
}).then(() => {
  return lightBall('three')
}).then(() => {
  return lightBall('four')
}).catch(err => {
  console.log("error was ", err)
})
```

Take a look at the final promise-ified solution:

<p data-height="550" data-theme-id="0" data-slug-hash="xRyMpK" data-default-tab="js,result" data-user="gammons" data-embed-version="2" data-pen-title="Promises" class="codepen">See the Pen <a href="http://codepen.io/gammons/pen/xRyMpK/">Promises</a> by Grant Ammons (<a href="http://codepen.io/gammons">@gammons</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="https://production-assets.codepen.io/assets/embed/ei.js"></script>

## Catching errors

If one of the `lightBall` functions returns an error, the sequence will stop running.

Take this code for instance:

```javascript
const lightBallsSequentially = () => {
  lightBall('one').then(() => {
    return lightBall('two')
  }).then(() => {
    return lightBall('nope') // This will throw an error!!
  }).then(() => {
    return lightBall('four')
  }).catch(err => {
    console.log("error was ", err)
  })
}
```

In the above code, `lightBall('four')` will never run.  Once the error is thrown, the `catch` block runs.

Here's the example of that:

<p data-height="550" data-theme-id="0" data-slug-hash="gLqrwY" data-default-tab="js,result" data-user="gammons" data-embed-version="2" data-pen-title="Promises with errors" class="codepen">See the Pen <a href="http://codepen.io/gammons/pen/gLqrwY/">Promises with errors</a> by Grant Ammons (<a href="http://codepen.io/gammons">@gammons</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="https://production-assets.codepen.io/assets/embed/ei.js"></script>

**Simulating `finally`**

Similarly to `then`, `catch` can also return stuff, which will also get wrapped in a promise.  This is a good way of "cleaning up" regardless if a function was successful or returned an error.

Notice that we do execute the last `then` block after the `catch` in the example below:

<p data-height="550" data-theme-id="0" data-slug-hash="JbxXEa" data-default-tab="js,result" data-user="gammons" data-embed-version="2" data-pen-title="Promises with errors, and a then at the end" class="codepen">See the Pen <a href="http://codepen.io/gammons/pen/JbxXEa/">Promises with errors, and a then at the end</a> by Grant Ammons (<a href="http://codepen.io/gammons">@gammons</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="https://production-assets.codepen.io/assets/embed/ei.js"></script>

## Parallel asynchronous events

You can also run promise-based functions using `Promise.all`.  Consider the following example:

<p data-height="550" data-theme-id="0" data-slug-hash="bBzoyW" data-default-tab="js,result" data-user="gammons" data-embed-version="2" data-pen-title="Parallel execution" class="codepen">See the Pen <a href="https://codepen.io/gammons/pen/bBzoyW/">Parallel execution</a> by Grant Ammons (<a href="http://codepen.io/gammons">@gammons</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="https://production-assets.codepen.io/assets/embed/ei.js"></script>

We're doing a lot of very similar looking, duplicative code in `lightBallsInParallel`.  By using `Promise.all`, it can be cleaned up significantly, and we get a single place to handle exceptions:

<p data-height="550" data-theme-id="0" data-slug-hash="yVZPOq" data-default-tab="js,result" data-user="gammons" data-embed-version="2" data-pen-title="Parallel execution with Promise.all" class="codepen">See the Pen <a href="https://codepen.io/gammons/pen/yVZPOq/">Parallel execution with Promise.all</a> by Grant Ammons (<a href="http://codepen.io/gammons">@gammons</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="https://production-assets.codepen.io/assets/embed/ei.js"></script>

Now, let's introduce an exception call.  Notice that even though the 3rd `lightBall` had an error, the fourth call still ran.

<p data-height="550" data-theme-id="0" data-slug-hash="zoePBb" data-default-tab="js,result" data-user="gammons" data-embed-version="2" data-pen-title="Parallel execution with Promise.all, with exception" class="codepen">See the Pen <a href="https://codepen.io/gammons/pen/zoePBb/">Parallel execution with Promise.all, with exception</a> by Grant Ammons (<a href="http://codepen.io/gammons">@gammons</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="https://production-assets.codepen.io/assets/embed/ei.js"></script>

# Conclusion

By now, you should be a freaking *ninja* at promises.  They are not too hard after the initial learning curve.

Remember, promises are great for the following reasons:

1. Your asynchronous code can be easier to read and maintain
2. You'll no longer need to reinvent this pattern on your own
3. You'll easily be able to grok other libraries who uses promises heavily or exclusively (like the `fetch` method, which I will cover next!)

So go forth with your newfound and start making (and potentially breaking) your promises!
