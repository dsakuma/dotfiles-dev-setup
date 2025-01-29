#############
# Functions #
#############

source_if_exists() {
  # source_if_exists <filename>
  if [[ -f "$1" ]]; then source "$1" || :; fi
}

is_macos() {
  if [[ $OSTYPE =~ "darwin" ]]; then true; else false; fi
}

is_macos_intel() {
  if [[ is_macos && $(uname -p) == 'i386' ]]; then true; else false; fi
}

is_macos_arm() {
  if [[ is_macos && $(uname -p) == 'arm64' ]]; then true; else false; fi
}

current_os() {
  if is_macos_intel; then
    "macos_intel"
  elif is_macos_arm; then
    "macos_arm"
  else
    "linux"
  fi
}


#################
# User settings #
#################

# Environment variables
export EDITOR=vim
export FZF_DEFAULT_COMMAND='fd'
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export PIPENV_VENV_IN_PROJECT=1
export SAVEHIST=10000

# Add to PATH
export PATH=$PATH:~/.local/bin # fdfind as fd in ubuntu

# brew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Aliases
alias dcup="docker-compose up"
alias ls='ls --color'
alias l='ls'
alias ll='ls -l'
alias lg='lazygit'
source_if_exists "$HOME/.git.zsh"

# zsh-syntax-highlighting
source_if_exists $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh # mac arm64 brew
source_if_exists "/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" # mac intel brew
source_if_exists "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" # ubuntu apt

# zsh-autosuggestions
source_if_exists "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh" # ubuntu apt

# fzf shell integration
source_if_exists "~/.fzf.zsh"

# Starship
eval "$(starship init zsh)"

# Mise
eval "$(mise activate zsh)"

# Android Studio
if is_macos; then
  export ANDROID_HOME=$HOME/Library/Android/sdk
else
  export ANDROID_HOME=$HOME/Android/Sdk
fi
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/emulator

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
