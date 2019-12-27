---

title: What I learned creating 12inch.reviews, a mashup of Spotify and Pitchfork
date: 2019-12-22 13:34 UTC
tags: sideproject

---

* Intro
  * I like music
  * I like pitchify.com
  * I like historical reviews
  * I wanted to create a simple site to mash together pitchfork's reviews with spotify's web playback SDK
* how it works
  * it's searchable collection of pitchfork's 20k+ album reviews
  * it all works via the frontend with a few key browser technologies to make it happen
  * backend
    * retriever
      * runs as a cron task on a server to process album data from Pitchfork
      * utilizes Pitchfork's [undocumented API][pitchfork_api] to get album reviews
      * has a small sqlite DB to keep track of its internal state and to know which albums are new
      * steps:
        * retrieve new albums from Pitchfork,
        * utilize Spotify's [search api][1] to attempt to find the associated album id and artist idj
        * store the new albums in retriever's sqlite DB
      * separate task:
        * create JSON files out of the sqlite DB.  these files are what will be served to the 12inch.reviews frontend.
        * uses an `initial.json` which gets served at page load time to populate initial album results onto the page

  * frontend
    * it's a `create-react-app` app
    * it utilizes modern browser's `indexedDB` to store all albums, loaded once with the JSON files payload
    * it does keep a copy of all albums loaded in memory, for searching and sorting
      * uses plain old javascript to do the searching
    * utilizes `storybook.js` to get the initial components styled and working correctly
    * Utilizes `tailwind.css`.
    * the initial album population occurs after the page is fully loaded, via `fetch` calls that retrieve 17 or so JSON files that represent each album
    * it's optimized to be a progressive web app and works well on phones
      * can be installed as a PWA on android devices
      * albums will play in the background, even while phone is locked

  * optimizations
    * could lean into flow typing more.
    * overall performance is still not great
    * utilize a service worker to populate the indexeddb

---

![](12inch.reviews.png)

There are a couple things to know about me:

1. I'm a huge music <strike>snob</strike> nerd.  I've played in many bands in my teens 20s, and music is a big part of my life.
2. I'm also a big fan of [Pitchfork][pitchfork] music reviews.

There was a mashup site I was using called [Pitchify][pitchify], which was no longer updating, and it eventually got taken down.  So I did what any engineer would do and I created my own mashup!

[12inch.reviews](https://12inch.reviews) is a mashup of Pitchfork's [album reviews][reviews] with Spotify's [web playback SDK][sdk].  It utilizes the browser's [IndexedDB API][indexeddb] to allow for fast, responsive searching and sorting of 17k+ album reviews, and allows you to play the full album right in the browser!

As with any side project, I had a few learning goals in mind that I wanted to bake in:

1. Continue to invest in learning React, specifically [React hooks][hooks], and progressive web apps.
2. Learn [tailwind.css][tailwind]
3. I wanted it to include *all* of Pitchfork's reviews, and have them be easily searchable.  There are a lot of seminal albums that I just haven't had exposure to.  Being able to find them easily would be a requirement.
4. I wanted to leverage different and interesting browser technologies to keep the main functionality of this site all on the frontend.
5. I wanted it to be completely completely [open source](https://github.com/gammons/12inch.reviews).

Pitchfork has over 20k reviews on their site, so being able to store that many records on the frontend, specifically in Javascript, would be a challenge.  Each browser has different [storage quotas](https://developers.google.com/web/tools/workbox/guides/storage-quota) that aren't particularly well-documented.  So I needed to think about how to work around these quotas in a seamless and transparent way.


## The backend

12inch.reviews uses a simple(ish) [retriever script][retriever] script that does the following:

1. utilizes Pitchfork's [undocumented API][pitchfork_api] to find new albums since the last time the script was run
2. Attempts to find that album using Spotify's [search API][spotify_search].
3. If found, add that album to a simple [SQLite](https://www.sqlite.org/index.html) DB

There is another backend function that will take the contents of the SQLite DB and to create a series of JSON files, which includes all the data the frontend needs.  The structure of each JSON album looks like so:

```json
    {
      "id": 13501,
      "pitchfork_id": "5929e2d1eb335119a49ef060",
      "title": "Out of Tune",
      "artist": "Mojave 3",
      "rating": "6.3",
      "bnm": false,
      "bnr": false,
      "label": "4AD",
      "url": "https://pitchfork.com/reviews/albums/5376-out-of-tune/",
      "description": "Out of Tune is a Steve Martin album. Yes, I'll explain: Once upon a time, there was ...",
      "genre": "Rock",
      "spotify_album_id": "2TLUvacBePI5753CqHPpxF",
      "spotify_artist_id": "4jSYHcSo85heWskYvAULio",
      "image_url": "https://i.scdn.co/image/ab67616d0000b27360b1fa1c0a15bcb97f9544a2",
      "page": null,
      "created_at": "1999-01-12 06:00:00 UTC",
      "updated_at": "2019-10-25 12:33:03 UTC",
      "timestamp": 916120800
    },
```

Once the JSON files are created, they are uploaded to S3 for the frontend to use.  Each album entry has all the info needed in order for Spotify's web SDK to use them on the frontend, and to be searchable.

The [retriever Rakefile][retriever_rakefile] also has functions to backfill all albums (takes multiple hours!) and has some utility functions to be able to create a new SQLite DB and other functions to massage the data into the correct format.

The main task, `refresh_and_upload` runs hourly.  Currently it's running as a [Kubernetes CronJob][cronjob] on my homelab Kube cluster (I'll talk more about that in another post).

### The frontend

The frontend of 12inch.reviews is a relatively simple `create-react-app` single-page app, that provides search and sort functionality, as well as the ability to play any album using Spotify's [web playback SDK][sdk].


**Getting all the album data**

When you visit 12inch.reviews the first time, it will show the albums from a small JSON file called `initial.json`.  This file includes only the first 25 most recent albums, so we have something to paint on the screen.

Then, the rest of the album data will be backfilled in via a series of `fetch`es to retrieve all of the JSON files.  I decided to partition each JSON file with 1000 albums, so there are 17 files altogether.  Each album JSON file is at least 600k uncompressed, so there is probably room for more optimization here.

After each JSON file is retrieved, they are stored in an IndexedDB on the frontend.  Subsequent visits to 12inch.reviews don't require the large JSON payload  - it will only load the delta payloads into the DB.  I'm taking advantage of the fact that these reviews are immutable - once they are written they will never change.

**Searching albums**

Although IndexedDB is great for *storing* this data, there is currently no functionality to actually *query* IndexedDB like a regular database.  So in order for 12inch.reviews to do searching and sorting, all of the data must be loaded into a [simple javascript array][albumstore].

**Playing albums**









[spotify_search]: https://developer.spotify.com/documentation/web-api/reference/search/search/
[pitchfork_api]: https://pitchfork.com/api/v2/search/?types=reviews
[pf]: https://pitchfork.com
[pitchfork]: https://pitchfork.com/
[pitchify]: http://pitchify.com
[tailwind]: https://tailwindcss.com/
[hooks]: https://reactjs.org/docs/hooks-intro.html
[sdk]: https://developer.spotify.com/documentation/web-playback-sdk/quick-start/
[reviews]: https://pitchfork.com/reviews/albums/
[indexeddb]: https://developer.mozilla.org/en-US/docs/Web/API/IndexedDB_API
[retriever]: https://github.com/gammons/12inch.reviews/blob/master/retriever/retrieve.rb
[retriever_rakefile]: https://github.com/gammons/12inch.reviews/blob/master/retriever/Rakefile
[cronjob]: https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/
[albumstore]: https://github.com/gammons/12inch.reviews/blob/master/src/app.js#L53
