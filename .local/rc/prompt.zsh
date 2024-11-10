#!/usr/bin/env zsh

setopt prompt_subst

function show_git_branch {
  local is_inside_work_tree branch_name st status_color
  local rebasing=""
  local has_stash=""

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
  else
    # other cases
    status_color="%F{004}"
  fi

  if [ -d $topdir/.git/rebase-merge ]; then
    rebasing=' ##'
  fi

  if git rev-parse --verify --quiet refs/stash >/dev/null; then
    has_stash=' $$'
  fi

  echo "${status_color}@${branch_name}${rebasing}${has_stash}%f"
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
