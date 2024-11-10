#!/usr/bin/env zsh

# Homebrew
export PATH="$(brew --prefix):$PATH"

## FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## pyenv
[[ -d $HOME/.pyenv/bin ]] && export PATH="$HOME/.pyenv/bin:$PATH" && eval "$(pyenv init -)"

## rbenv
[ -f ~/.rbenv/bin/rbenv ] && eval "$(~/.rbenv/bin/rbenv init - zsh)"

## Go
export PATH=$PATH:$HOME/go/bin

## Volta
export PATH="$HOME/.volta/bin:$PATH"
