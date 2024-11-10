#!/usr/bin/env zsh

## FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

## rbenv
eval "$(~/.rbenv/bin/rbenv init - zsh)"

## Go
export PATH=$PATH:$HOME/go/bin
