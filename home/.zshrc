# Functions
# ---------
eval_if_exists()   { if command -v "$1" &> /dev/null; then eval "$("$1" "${@:2}")"; fi }
source_if_exists() { if [[ -f "$1" ]]; then source "$1"; fi }

is_macos()         { [[ $OSTYPE =~ "darwin" ]]; }
is_macos_arm()     { is_macos && [[ $(uname -p) == 'arm64' ]]; }
is_macos_intel()   { is_macos && [[ $(uname -p) == 'i386' ]]; }

# Environment variables
# ---------------------
export ANDROID_HOME=$(if is_macos; then echo "$HOME/Library/Android/sdk"; else echo "$HOME/Android/Sdk"; fi)
export EDITOR=vim
export FZF_DEFAULT_COMMAND='fd'
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export PIPENV_VENV_IN_PROJECT=1
export SAVEHIST=10000

# Path configuration
# ------------------
export PATH=$PATH:~/.local/bin # fdfind as fd in ubuntu
export PATH=$PATH:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator

# Aliases
# -------
alias dcup="docker-compose up"
alias ls="ls --color"
alias lg="lazygit"
alias update="$(if is_macos; \
  then echo 'brew upgrade && brew update'; \
  else echo 'sudo snap refresh && sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && brew update && brew upgrade && flatpak update'; fi)"
source_if_exists "$HOME/.git.zsh"

# Plugins and frameworks
# ----------------------

# Homebrew
for brew_path in "/home/linuxbrew/.linuxbrew/bin/brew" "/usr/local/bin/brew"; do
  eval_if_exists "$brew_path" "shellenv"
done

# zsh-syntax-highlighting
for zsh_syntax_highlight_path in "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
  "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"; do
  source_if_exists "$zsh_syntax_highlight_path"
done

# zsh-autosuggestions
for zsh_autosuggestions_path in "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" \
  "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh"; do
  source_if_exists "$zsh_autosuggestions_path"
done

# fzf
source_if_exists /usr/share/doc/fzf/examples/key-bindings.zsh
source_if_exists /usr/share/doc/fzf/examples/completion.zsh  
# source <(fzf --zsh) # for fzf 0.48 or later

# Starship
eval "$(starship init zsh)"

# Mise
eval "$(mise activate zsh)"

# Cargo
source_if_exists "/home/dsakuma/.cargo/env"
