---

title: Some tips for using btrfs
date: 2019-07-20 11:26 UTC
tags: linux btrfs

---

I've been using [btrfs](https://btrfs.wiki.kernel.org/index.php/Main_Page) for as the filesystem for my primary laptop for a while now.  

Btrfs is a copy-on-write filesystem for Linux that has many advanced features:

* 
* Compression that offers 
* Zero-cost snapshotting

If you haven't read up about it, there's some real advantages to using a system like this

### Setting up btrfs on your system


### Disabling quota support

Btrfs (at least on Arch linux) has quota support enabled by default.  This is a problem, because it can greatly impact the performance of your system overall.  I was practically ripping my hair out trying to find out what was causing so much IO and CPU burn on my system, especially when sending snapshots to an external disk.

It turns out that `btrfs-quota` was the culprit.  Even the [quota wiki page](https://btrfs.wiki.kernel.org/index.php/Manpage/btrfs-quota) notes that there are performance implications of enabling quota support, and it should only be enabled if it will actually be used.

For my system, I ran the following two commands: 

```
btrfs disable quota /
btrfs disable quota /home
```

...and all my performance problems were solved.


### Toggling readonly status of snapshots

```
sudo btrfs property set -ts butter-backer-snap ro false
```
