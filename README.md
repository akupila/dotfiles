# dotfiles

My dotfiles.

## yadm

```bash
brew install yadm
```

## neovim

```bash
brew install neovim
```

Deoplete needs python3:

```
brew install python3
pip3 install neovim
```

## vim-plug

Plugin manager for vim

```bash
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

## Install dotfiles

```bash
yadm clone git@github.com:akupila/dotfiles.git
```

## Install powerline fonts (for vim airline)

https://github.com/powerline/fonts

## Install reattach-to-user-namespace for fixing copy-paste in tmux

```
brew install reattach-to-user-namespace
```
