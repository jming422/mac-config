# -*- mode: sh; -*-
source ~/.bashrc

# Disable XON/XOFF so that C-s does forward i-search
stty -ixon

# Plugins, completions, etc.
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
