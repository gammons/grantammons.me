---

title: How to efficiently manage your dotfiles
date: 2017-11-26 22:22 UTC
tags: linux-desktop

---

[Dotfiles](https://thoughtbot.com/upcase/videos/intro-to-dotfiles) are a large part of Linux desktop hygiene.  If you want too

* what are dotfiles
* why it's a good idea to organize your dotfiles in a git repository
* managing secrets with dotfiles:q
* using a repository to manage your dotfiles
* the dotfiles directory structure
* using a manager
* using Thoughtbot's dotfiles
  * rcup, etc
  *

## What are dotfiles?

Dotfiles are plain-text configuration files for various programs that you use.  These files typically reside in the root of your home directory (e.g. `/home/grant`) and are prefixed with a dot (e.g. `/home/grant/.vimrc`).  Dotfiles are becoming a more general term for any type of configuration file needed for your setup.

Most programs nowadays are slowly moving to the [XDG base directory specification](https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html), which define `$XDG_CONFIG_HOME` as `$HOME/.config`.  This is why you now see many files in `~/.config/programname/configfile`.

## Dotfile organization

It is a *fantastic* idea to keep your dotfiles organized in a git repository.  This affords many conveniences:

1. Easily port your configs over to another computer or laptop (or recover from a crash on your main desktop)
2. The ability to try out new configurations without messing up your existing, known-to-be-working configs
3. Use commit messages to help documented why a change was made to your configs.
4. Show the greater community a new trick, or way to
5.


It's a good idea to store your dotfiles in Github, under the "special" name `dotfiles` (by convention).   Most people do not actually put the dots in front of the filenames they store in the repo.   So for instance, in the repo, your `.vimrc` would actually be stored as `vimrc`.


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


## Installing dotfiles

## Discovering awesome configs


## Other dotfiles resources





