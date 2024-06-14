#############
# Functions #
#############

source_if_exists() {
  # source_if_exists <filename>
  if [[ -f "$1" ]]; then source "$1" || :; fi
}

is_ssh() {
  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then true; else false; fi
}

is_macos() {
  if [[ $OSTYPE =~ "darwin" ]]; then true; else false; fi
}

is_macos_intel() {
  if [[ is_macos && $(uname -p) == 'i386' ]]; then true; else false; fi
}

#################
# User settings #
#################

# Environment variables
export EDITOR=vim
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export FZF_DEFAULT_COMMAND='fd'
export PIPENV_VENV_IN_PROJECT=1
export SAVEHIST=10000
export TERM=xterm-256color # Fix color in lightline.vim

# Aliases
alias dcup="docker-compose up"
alias ls='ls --color=auto'
alias l='ls -lFh'
alias ll='ls -lFha'
alias cd='z'
# alias ls='eza'
# alias l='exa -l'
# alias ll='eza -al'
# alias tree='eza --tree'
source_if_exists "$HOME/.git.zsh"

# oh-my-zsh
# export ZSH=$HOME/.oh-my-zsh
# ZSH_THEME="robbyrussell"
# source_if_exists $ZSH/oh-my-zsh.sh

# zsh plugins
source_if_exists $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh # brew arm64
source_if_exists "/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" # brew intel
source_if_exists "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" # aur
source_if_exists "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" # apt

# Start ssh-agent on Linux
if ! pgrep ssh-agent > /dev/null; then # wsl
  rm -f /tmp/ssh-auth-sock
  eval "$(ssh-agent -s -a /tmp/ssh-auth-sock)"
elif [ -z $SSH_AUTH_SOCK ]; then # wsl
  export SSH_AUTH_SOCK=/tmp/ssh-auth-sock
fi

# Android Studio
if is_macos; then
  export ANDROID_HOME=$HOME/Library/Android/sdk
else
  export ANDROID_HOME=$HOME/Android/Sdk
fi
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/emulator

# Conda
source_if_exists "/opt/miniconda3/etc/profile.d/conda.sh" # pamac

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

# fdfind as fd in ubuntu
export PATH=$PATH:~/.local/bin

# fzf shell integration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Starship
eval "$(starship init zsh)"

# Zoxide
eval "$(zoxide init zsh)"

