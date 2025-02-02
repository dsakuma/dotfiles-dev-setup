#############
# Functions #
#############

source_if_exists() { if [[ -f "$1" ]]; then source "$1"; fi }
eval_if_exists()   { if command -v "$1" &> /dev/null; then eval "$("$1" "${@:2}")"; fi }

# OS checks
is_macos()         { [[ $OSTYPE =~ "darwin" ]]; }
is_macos_intel()   { is_macos && [[ $(uname -p) == 'i386' ]]; }
is_macos_arm()     { is_macos && [[ $(uname -p) == 'arm64' ]]; }


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
export PATH=$PATH:~/.local/bin # fdfind as fd in ubuntu

# brew
eval_if_exists "/home/linuxbrew/.linuxbrew/bin/brew" "shellenv"

# Aliases
alias dcup="docker-compose up"
alias ls='ls --color'
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
export ANDROID_HOME=$(if is_macos; then echo "$HOME/Library/Android/sdk"; else echo "$HOME/Android/Sdk"; fi)
export PATH=$PATH:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator

