#!/usr/bin/env zsh

export EDITOR='hx'
export KERL_CONFIGURE_OPTIONS="--without-javac"
export PIPENV_MAX_DEPTH=7
export SAM_CLI_TELEMETRY=0

# Path-like vars
export CARGO_HOME="$XDG_CONFIG_HOME/cargo"
export HOMEBREW_BUNDLE_FILE="$XDG_CONFIG_HOME/Brewfile"
export JAVA_HOME=$(/usr/libexec/java_home) # See: /usr/libexec/java_home -V
export LLVM_CONFIG='/opt/homebrew/opt/llvm@14/bin/llvm-config'
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/opt/homebrew/opt/openssl/lib/pkgconfig"
export RUSTUP_HOME="$XDG_CONFIG_HOME/rustup"

# Load scripts
. "/Users/jming/.config/cargo/env"

# emacs vterm directory tracking
source "$XDG_CONFIG_HOME/vterm-dir-tracking.sh"
autoload -U add-zsh-hook
add-zsh-hook -Uz chpwd (){ vterm_set_directory }

# misc
LESS="-RF"
