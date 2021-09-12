# Globally desirable aliases
alias activate="source venv/bin/activate"
alias ..="cd .."
alias cdf="cd ~/docs/focus"
alias grep="grep --color=auto"
alias l="ll"
alias ll="ls -alh"
alias lr="lein repl"
alias ls="ls -G"
alias pgstart="pg_ctl -D /usr/local/var/postgres start"
alias pgstop="pg_ctl -D /usr/local/var/postgres stop"
alias cenv='env -S $(cat .env)'
alias d='emacs -nw --with-profile doom'
alias de='emacs --with-profile doom'
alias crap='ps -ef | grep scrape'
alias rek='kill -KILL'

eval "$(starship init bash)"

# Terminal modifiers
# PS1="\A \w \$ "
export GPG_TTY=$(tty)
export EDITOR="emacsclient"

# aws vars
export SAM_CLI_TELEMETRY=0

# go setup
export GOPATH="$HOME/Documents/go"

# java setup
export JAVA_HOME="/Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home"

# Path
# Since vterm inherits from Emacs's env which already has the PATH set; don't double set the PATH as this will mess up nvm.
if [[ "$INSIDE_EMACS" != 'vterm' ]]; then
    export PATH="/usr/local/opt/mysql-client/bin:/usr/local/sbin:$HOME/.cargo/bin:$GOPATH/bin:$HOME/.config/doom-emacs/bin:$PATH"
fi

# export SOURCEKIT_TOOLCHAIN_PATH="/Library/Developer/Toolchains/swift-latest.xctoolchain"

export XDG_CONFIG_HOME="~/.config"

# Plugins, completions, etc.
HOMEBREW_PREFIX=$(brew --prefix)
export BASH_COMPLETION_COMPAT_DIR="${HOMEBREW_PREFIX}/etc/bash_completion.d"
if type brew &>/dev/null; then
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
      [[ -r "$COMPLETION" ]] && source "$COMPLETION"
    done
  fi
fi

# autocomplete setups
HEROKU_AC_BASH_SETUP_PATH="$HOME/Library/Caches/heroku/autocomplete/bash_setup" && test -f $HEROKU_AC_BASH_SETUP_PATH && source $HEROKU_AC_BASH_SETUP_PATH;

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# vterm directory tracking
source "$HOME/.config/vterm-dir-tracking.sh"
