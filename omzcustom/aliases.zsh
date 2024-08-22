#!/usr/bin/env zsh

alias ..='cd ..'
alias cdf='cd ~/Documents/focus'
alias ll='ls -alh'
alias 🍻='brew update && brew upgrade && brew bundle dump -f && brew bundle'
alias magit='emacs -nw -f magit-status'
alias lg='lazygit'

# learned from https://github.com/wez/wezterm/blob/30345b36d8a00fed347e4df5dadd83915a7693fb/assets/shell-integration/wezterm.sh#L447-L458
# sending OSC 7 in between warping and the command is necessary in order for the terminal to catch the changed directory
# in time, otherwise it won't pick it up until the command is exited, but I mainly use these for long-running commands
# like editors
warp_and_exec() {
  wd $1
  if hash wezterm 2>/dev/null ; then
    wezterm set-working-directory 2>/dev/null
  else
    printf "\033]7;file://%s%s\033\\" "${HOSTNAME}" "${PWD}"
  fi
  $2
}

alias fx='warp_and_exec f hx'
alias fl='warp_and_exec f lazygit'
alias dx='warp_and_exec d8s hx'
alias dl='warp_and_exec d8s lazygit'
