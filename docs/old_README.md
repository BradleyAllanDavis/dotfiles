# My *dotfiles*
Welcome to my Unix configuration files!
They say life is a journey, not a destination. Well, so are *dotfiles*...

## Current Tools

* [Cross Platform](.config/docs/CrossPlatform.md)
* [macOS](.config/docs/macOS.md)
* [Linux](.config/docs/Linux.md)
* [Windows](.config/docs/Windows.md)

## Installation

### WARNING!
You probably should not install these unless you like your system configured
**exactly** like I do, which is highly unlikely. That being said, if you do want to
install my *dotfiles*, buyer beware. Make sure to backup your existing *dotfiles*
if you have configured anything you care about keeping. **Running my symlink
script will clobber your existing dotfiles.** Probably the best course of action
is to take what looks good and integrate it into your own *dotfiles* over time.

#### Requirements
* [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
* [python](https://www.python.org/downloads/)

Clone this repository to whatever directory you would like (preferably `$HOME`).
I like to use [Dropbox](https://www.dropbox.com) to keep my *dotfiles* in sync
across my Macs machines so I clone within `~/Dropbox`.

Create ssh key and upload to GitHub.

```bash
git clone git@github.com:BradleyAllanDavis/dotfiles.git ~/.dotfiles
```

After cloning the repository, you need to source the symlink script, which will
link all the *dotfiles* to the home directory and re-load your bash configuration.
**WARNING: This will clobber your current dotfiles**.

```bash
python ~/.dotfiles/.config/symlink_dotfiles.py
```

On macOS 10.15+ change shell to bash.
```
chsh -s /bin/bash
```

That's it! The *dotfiles* are installed and you are ready to get your Unix on!

### Post Install

#### Homebrew
Install [homebrew](https://brew.sh/)
```
~/.dotfiles/.config/homebrew/install_homebrew_mac.sh
```

#### Vim/Neovim
When you open `vim` or `nvim` for the first time after you will
need to `<space>pi` to install plugins through Plug. Relaunch `vim` and you are
good to go.

#### Tmux
When you open `tmux` for the first time you will
need to type `<ctrl-b>I` to install plugins through TPM.

## Uninstall
To be determined...

## Postlude
These are very much still a work in progress and have been heavily inspired by
so many on GitHub and across the web. Many thanks to those in the *dotfiles*
community.












































































