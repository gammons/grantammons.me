---

title: How to efficiently manage your dotfiles
date: 2017-11-26 22:22 UTC
tags: linux-desktop

---

Dotfiles and dotfile management are a foundational keystone to an organized, repeatable workflow.  They are a must if you're a developer, and also become critically important to properly manage if you're planning on running Linux as your primary desktop experience.

## What are dotfiles?

Dotfiles are plain-text configuration files for various programs that you use.  These files typically reside in the root of your home directory (e.g. `/home/grant`) and are prefixed with a dot (e.g. `/home/grant/.vimrc`).  Dotfiles are becoming a more general term for any type of configuration file needed for your setup.

Most programs nowadays are slowly moving to the [XDG base directory specification](https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html), which define `$XDG_CONFIG_HOME` as `$HOME/.config`.  This is why you now see many files in `~/.config/programname/configfile`.

## Organizing dotfiles

Having a meticulously organized set of dotfiles is good hygiene and good practice.  Disasters happen.  Laptops get lost or stolen.  Hard drives die.  When dotfiles are properly managed, it allows you to get your computer back to feeling like "home" very quickly!

1. Easily port your configs over to another computer or laptop (or recover from a crash on your main desktop)
2. The ability to try out new configurations without messing up your existing, known-to-be-working configs
3. Use commit messages to help documented why a change was made to your configs.
4. Add to the collective hivemind of the greater community.  Learn from others, and have others learn from you.

It's a good idea to store your dotfiles in Github, under the "special" name `dotfiles` (by convention).   Most people do not actually put the dots in front of the filenames they store in the repo.   So for instance, in the repo, your `.vimrc` would actually be stored as `vimrc`.

Any personal executable scripts you have should also be stored here, in a `bin` folder.  You can then set up your `PATH` to include `~/.bin` to have access to those scripts.

If you plan on really hacking your Linux desktop experience or using a tiling window manager like [i3](https://i3wm.org/), good dotfiles hygiene is a must.  You'll be storing all of your hard-earned configs there.

## Installing dotfiles

Using an automated tool to install dotfiles as symlinks is a best practice.  The installation tool will create symlinks of the files in your dotfiles repo, in the correct location:

```zsh
➜  ~ ls -la .vimrc
lrwxrwxrwx 1 grant grant 26 Oct 17 15:17 .vimrc -> /home/grant/dotfiles/vimrc
```

Additionally, any directories in your `dotfiles` repo should be installed with dots in front of them as well.  For instance, the installer should create a symlink called `~/.config` for your folder in `~/dotfiles/config`.

**Some great dotfile managers:**

* [RCM](https://github.com/thoughtbot/rcm) - [ThoughtBot's](https://thoughtbot.com/) homegrown tool for managing dotfiles.  This is the one I personally use.
* [YADM](https://thelocehiliosan.github.io/yadm/) - Yet another dotfiles manager
* [GNU Stow](https://www.gnu.org/software/stow/) - The old school choice.
* [Dotbot](https://github.com/anishathalye/dotbot) - Uses a YAML or JSON file to store configuration.

## Secret management

Originally, I was recommending a solution based on keeping secrets stored in a `~/.secrets` file with the secrets stored as environment variables.  This emulates Heroku's [12-factor approach](https://12factor.net).  However, after talking with colleagues, this approach is not ideal for a desktop environment, and here's why:

1. You now have a plaintext file on your hard drive that is storing sensitive information.  There are tools for handling sensitive info, so use them!
2. Crash reports that get shipped off usually include environment variables.  You don't have control over where your secrets go.
3. On a desktop machine, processes can easily spawn many sub-processes, each of which now has access to sensitive environment variables.

A good alternative is to Use a password store like `pass` or `lpass` and store sensitive info as a note.  You can write a quick script to decrypt and use in an environment variable as needed.  It explicitly limits the scope of how far sensitive information can travel, and it keeps this info behind your passphrase.

## Using a curated set of base dotfiles

We can go deeper!  Many people (including me) use a curated set of dotfiles as a "base" to build upon.  For my workflow, using [Thoughtbot's dotfiles](https://github.com/thoughtbot/dotfiles) is a perfect starting point:

* Their starting vim configuration includes [vim-plug](https://github.com/junegunn/vim-plug), [Ag](https://github.com/ggreer/the_silver_searcher), [Rails.vim](https://github.com/tpope/vim-rails), and [Ctrl-P](https://github.com/ctrlpvim/ctrlp.vim) out of the box.
* Sensible defaults for using git, rspec, tmux and ag.

When using Thoughtbot's dotfiles, your own personal configs would go into `~/dotfiles-local`.

The benefits of using a set of base dotfiles is that someone has already culled together best practices.  A drawback, however, is the cognitive load associated with actually *learning* what is in them, how they work, what shortcuts they provide.  If you're declaring dotfile bankruptcy (which I have, twice), or are just starting out, it's worth considering base dotfiles that are sensible.  I like Thoughtbot, and I consider their dotfiles sensible, which is why I chose them as a good base.

## Dotfiles and the Perfect Linux Desktop™

Dotfile management becomes even more important if you're crafting together a linux desktop experience.  I am personally running [i3wm](https://i3wm.org/).  All of i3's config is in a single file, stored in `~/.config/i3/config`.  Many users of i3 also use a nice bar called [Polybar](https://github.com/jaagr/polybar) which stores its config in `~/.config/polybar/config`. (See the pattern yet).  There's also keyboard/mouse settings, dunst (a minimal notification manager), and others!  Basically, your whole desktop configuration comes under the umbrella of dotfiles.  Therefore, managing your dotfiles effectively becomes crucial to having a good experience.

I am running i3 on a laptop and a desktop machine, and each have slightly different configs.  For [my own dotfiles](https://github.com/gammons/dotfiles-local), I keep 2 different branches for each config (`master` and `laptop` in this case).

I am a frequenter of the [/r/unixporn](https://www.reddit.com/r/unixporn/) subreddit (safe for work despite name) where you can get inspired and see fantastic looking desktops.  Most of the content submitters also share their dotfiles so you can replicate their setups!

<div class="caption">
  <img src="https://i.imgur.com/kRxuRrf.png" />
  Some folks get quite creative with their desktop setups, and they are always happy to <a href="https://www.reddit.com/r/unixporn/comments/7f6uh2/xfwm_my_kind_of_pornography/dq9tmcl/">share their dots!</a>
</div>

Alongside /r/unixporn, [Luke Smith](http://lukesmith.xyz/) has a great (albeit extremely meme-heavy)[Youtube channel](https://www.youtube.com/LukeSmithxyz) walking through the benefits of using a tiling window manager.  He also [shares his dotfiles](https://github.com/LukeSmithxyz/voidrice) and focuses on teaching others on how to craft a desktop experience like his.

<script async id="_ck_304426" src="https://forms.convertkit.com/304426?v=6"></script>

## Summary

Good dotfile hygiene is important for having a nice, repeatable, enjoyable computing experience.  It allows you to stay organized, easily port your setup to other machines, and to have confidence to experiment without messing things up.

If you're striving for a fantastic Linux desktop experience, dotfile management becomes essential, because that's how you'll be tweaking and refining your entire desktop experience.

I hope after reading this, you're excited to experiment, curate, and move your dotfiles to the next level!

