bindkey -e
export EDITOR=vim
export LESS="-iMR"

for file in ~/.local/rc/*.zsh(.); do
  source "$file"
done

export PATH=$PATH:$HOME/.local/bin
