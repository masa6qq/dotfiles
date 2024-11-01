bindkey -e

# zplug

source ~/.zplug/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'

zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=246'

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

# Then, source plugins and add commands to $PATH
zplug load


# Packages

## FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

## rbenv
eval "$(~/.rbenv/bin/rbenv init - zsh)"

## Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Prompt

## Referencing variables
setopt prompt_subst

function show_git_branch {
  local is_inside_work_tree branch_name st status_color

  is_inside_work_tree=`git rev-parse --is-inside-work-tree 2>/dev/null`
  if [ "$is_inside_work_tree" != "true" ]; then
    return
  fi
  local topdir=$(git rev-parse --show-toplevel 2>/dev/null)

  branch_name=`git rev-parse --abbrev-ref HEAD 2>/dev/null`
  st=`git status 2>/dev/null`
  if [ ! -e ".git" ]; then
    status_color="%F{246}"
  elif [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    # Already committed
    status_color="%F{014}"
  elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
    status_color="%F{013}"
  elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
    status_color="%F{013}"
  elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
    status_color="%F{011}"
  elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
    # Conflicts occur
    echo "%F{013}no branch%f"
    return
  else
    # other cases
    status_color="%F{004}"
  fi

  if [ -d $topdir/.git/rebase-merge ]; then
    echo "${status_color}@${branch_name}%f %F{011}!Rebasing%f"
  else
    echo "${status_color}@${branch_name}%f"
  fi
}

function show_prompt {
  prev_exit_code=$(echo $?)

  if [ $prev_exit_code = 0 ]; then
    color_code=007
  elif [ $prev_exit_code = 127 ]; then
    color_code=011
  else
    color_code=009
  fi

  echo "\n%B%F{${color_code}}%~%f $(show_git_branch)\n%F{250}>%f%b "
}

PROMPT='$(show_prompt)'
