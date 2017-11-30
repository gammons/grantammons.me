---

title: How to efficiently manage your dotfiles
date: 2017-11-26 22:22 UTC
tags: linux-desktop

---

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

"But how do I keep mah secretz secret?" Great question!  Once you start really getting into storing, managing, and curating your dotfiles, it's inevitable that you'll need to store some sort of secret information there.  In this case, we can lift a concept from Heroku's [12-factor app](https://12factor.net/) concept, and store sensitive info in [environment variables](https://12factor.net/config).

I create a `~/.secrets` file, which exports keys and other secret info as environment variables.

```bash
export AWS_ACCESS_KEY=ABCD1234
export AWS_SECRET_ACCESS_KEY=ABCD1234ABCD1234
```

Then, at the bottom of my `~/.zshrc` file, I have the line:

```
source ~/.secrets
```

This will load my environment variables into my session, which I can then reference in other files.  The secrets are secure, and you don't need to worry about checking in sensitive info to your repo!

## Using a curated set of base dotfiles

We can go deeper!  Many people (including me) use a curated set of dotfiles as a "base" to build upon.  For my workflow, using [Thoughtbot's dotfiles](https://github.com/thoughtbot/dotfiles) is a perfect starting point:

* Their starting vim configuration includes [vim-plug](https://github.com/junegunn/vim-plug), [Ag](https://github.com/ggreer/the_silver_searcher), [Rails.vim](https://github.com/tpope/vim-rails), and [Ctrl-P](https://github.com/ctrlpvim/ctrlp.vim) out of the box.
* Sensible defaults for using git, rspec, tmux and ag.

When using Thoughtbot's dotfiles, your own personal configs would go into `~/dotfiles-local`.

The benefits of using a set of base dotfiles is that someone has already culled together best practices.  A drawback, however, is the cognitive load associated with actually *learning* what is in them, how they work, what shortcuts they provide.  If you're declaring dotfile bankruptcy (which I have, twice), or are just starting out, it's worth considering base dotfiles that are sensible.  I like Thoughtbot, and I consider their dotfiles sensible, which is why I chose them as a good base.

## Learning from others





