# -*- mode: sh; -*-
# Globally desirable aliases
alias activate="source venv/bin/activate"
alias ..="cd .."
alias cdf="cd ~/Documents/focus"
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

export XDG_CONFIG_HOME="$HOME/.config"

# Terminal modifiers
# PS1="\A \w \$ "
export GPG_TTY=$(tty)
export EDITOR="emacsclient"

# aws vars
export SAM_CLI_TELEMETRY=0

# Path vars
export GOPATH="$HOME/Documents/go"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home"
export CARGO_HOME="$XDG_CONFIG_HOME/cargo"
export RUSTUP_HOME="$XDG_CONFIG_HOME/rustup"
. "/Users/jming/.config/cargo/env"

# Path
# Since vterm inherits from Emacs's env which already has the PATH set; don't double set the PATH as this will mess up nvm.
if [[ "$INSIDE_EMACS" != 'vterm' ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    export PATH="$HOME/.local/bin:$GOPATH/bin:$HOME/Library/Application Support/Coursier/bin:$XDG_CONFIG_HOME/doom-emacs/bin:$PATH"
fi

eval "$(starship init bash)"
eval "$(direnv hook bash)"

# vterm directory tracking
source "$XDG_CONFIG_HOME/vterm-dir-tracking.sh"

# export SOURCEKIT_TOOLCHAIN_PATH="/Library/Developer/Toolchains/swift-latest.xctoolchain"

# Plugins, completions, etc.
HOMEBREW_PREFIX=$(brew --prefix)
export HOMEBREW_BUNDLE_FILE="$XDG_CONFIG_HOME/Brewfile"
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

# nvm
export NVM_DIR="$XDG_CONFIG_HOME/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# heroku autocomplete setup
HEROKU_AC_BASH_SETUP_PATH="$HOME/Library/Caches/heroku/autocomplete/bash_setup" && test -f $HEROKU_AC_BASH_SETUP_PATH && source $HEROKU_AC_BASH_SETUP_PATH;
