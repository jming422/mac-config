# -*- mode: sh; -*-
# Globally desirable aliases
alias ..="cd .."
alias cdf="cd ~/Documents/focus"
alias grep="grep --color=auto"
alias ll="ls -alh"
alias ls="ls -G"
alias cenv='env -S $(cat .env)'
alias 🍻='brew update && brew upgrade && brew bundle dump -f && brew bundle'
alias magit='emacs -nw -f magit-status'

export XDG_CONFIG_HOME="$HOME/.config"

# Terminal modifiers
# PS1="\A \w \$ "
GPG_TTY=$(tty)
export GPG_TTY
export EDITOR="vim"

# aws vars
export SAM_CLI_TELEMETRY=0

# Path vars
export GOPATH="$HOME/Documents/go"
# See: $ /usr/libexec/java_home -V
JAVA_HOME=$(/usr/libexec/java_home)
export JAVA_HOME
export CARGO_HOME="$XDG_CONFIG_HOME/cargo"
export RUSTUP_HOME="$XDG_CONFIG_HOME/rustup"
. "/Users/jming/.config/cargo/env"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/opt/homebrew/opt/openssl/lib/pkgconfig"

# Path
# Since vterm inherits from Emacs's env which already has the PATH set; don't double set the PATH as this will mess stuff up.
if [[ "$INSIDE_EMACS" != 'vterm' ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  export PATH="$HOME/.local/bin:$GOPATH/bin:$XDG_CONFIG_HOME/emacs/bin:$PATH"
fi

if [[ -z "$JM_NO_INTERACTIVE" ]]; then
  eval "$(starship init bash)"
  eval "$(direnv hook bash)"
fi

export KERL_CONFIGURE_OPTIONS="--without-javac"

# asdf version manager
. "/opt/homebrew/opt/asdf/libexec/asdf.sh"

source "${XDG_CONFIG_HOME}/asdf-direnv/bashrc"

# vterm directory tracking
source "$XDG_CONFIG_HOME/vterm-dir-tracking.sh"
PROMPT_COMMAND="vterm_set_directory${PROMPT_COMMAND:+; $PROMPT_COMMAND}"


# export SOURCEKIT_TOOLCHAIN_PATH="/Library/Developer/Toolchains/swift-latest.xctoolchain"

export LLVM_CONFIG=/opt/homebrew/opt/llvm@14/bin/llvm-config

# Plugins, completions, etc.
if type brew &>/dev/null; then
  export HOMEBREW_BUNDLE_FILE="$XDG_CONFIG_HOME/Brewfile"
  export BASH_COMPLETION_COMPAT_DIR="${HOMEBREW_PREFIX}/etc/bash_completion.d"
  HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
      [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
    done
  fi
fi

# pipenv
export PIPENV_MAX_DEPTH=7

# heroku autocomplete setup
HEROKU_AC_BASH_SETUP_PATH="$HOME/Library/Caches/heroku/autocomplete/bash_setup" && test -f $HEROKU_AC_BASH_SETUP_PATH && source $HEROKU_AC_BASH_SETUP_PATH
