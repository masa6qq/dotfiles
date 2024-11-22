#!/usr/bin/env zsh

# Homebrew
type brew > /dev/null 2>&1 && export PATH="$(brew --prefix):$PATH"

## FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## pyenv
type pyenv > /dev/null 2>&1 && eval "$(pyenv init -)"

## rbenv
[ -f ~/.rbenv/bin/rbenv ] && eval "$(~/.rbenv/bin/rbenv init - zsh)"

## Go
export PATH=$PATH:$HOME/go/bin

## Volta
export PATH="$HOME/.volta/bin:$PATH"
