# Left Prompt

function left_prompt {
  if [ $(echo $?) = 0 ]; then
    color_code=248
  else
    color_code=208
  fi

  echo "%F{${color_code}}%D %T | %~ ~$ %f"
}

PROMPT='`left_prompt`'


# Display git branch names with color
function rprompt_git_current_branch {
  local branch_name st branch_status status_color
 
  if [ ! -e ".git" ]; then
    # Not git managed.
    return
  fi
  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    # Already committed
    branch_status="💫"
		status_color="%F{green}"
  elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
    branch_status="📮"
		status_color="%F{red}"
  elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
    branch_status="🚧"
		status_color="%F{red}"
  elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
    branch_status="🚀"
		status_color="%F{yellow}"
  elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
    # Conflicts occur
    echo "%F{red}💥 no branch"
    return
  else
    # other cases
    branch_status="🤔"
		status_color="%F{blue}"
  fi

  echo "${branch_status} in ${status_color}${branch_name}%f"
}
 
# Referencing variables
setopt prompt_subst
 	
# Right Prompt
RPROMPT='`rprompt_git_current_branch`'

# PATH

export PATH="/usr/local/bin:$PATH"
