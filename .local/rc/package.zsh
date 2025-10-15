#!/usr/bin/env zsh

# Homebrew
export PATH="$(brew --prefix):$PATH"

## FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## pyenv
eval "$(pyenv init -)"

## rbenv
[ -f ~/.rbenv/bin/rbenv ] && eval "$(~/.rbenv/bin/rbenv init - zsh)"

## Go
export PATH=$PATH:$HOME/go/bin

## mise
eval "$(~/.local/bin/mise activate zsh)"

export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
export LIBRARY_PATH=$LIBRARY_PATH:$(brew --prefix zstd)/lib/

export PATH="$HOME/.plenv/bin:$PATH"
eval "$(plenv init -)"
