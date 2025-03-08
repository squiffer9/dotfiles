# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#################################[ Environment Variables ]###################################
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR=nvim
export VISUAL=nvim
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# Build flags
export LDFLAGS="-L/opt/homebrew/lib"
export CPPFLAGS="-I/opt/homebrew/include"

# Docker configuration
export DOCKER_HOST="unix:///var/run/docker.sock"
export DOCKER_BUILDKIT=1

################################[ Path Configuration ]#######################################
# Base path
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="$HOME/.local/bin:$PATH"  # Path for `pip install --user`

# Language-specific paths are set with each version manager below

################################[ Zinit (Plugin Manager) ]###################################
if [[ ! -f ~/.zinit/bin/zinit.zsh ]]; then
    mkdir -p ~/.zinit && git clone https://github.com/zdharma-continuum/zinit.git ~/.zinit/bin
fi
source ~/.zinit/bin/zinit.zsh

# Load plugins
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab

################################[ Completion and History ]##################################
# Tab completion
autoload -Uz compinit && compinit

# History settings
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt APPEND_HISTORY          # Append to history
setopt HIST_IGNORE_ALL_DUPS    # Remove duplicate commands
setopt HIST_IGNORE_SPACE       # Don't save commands starting with space
setopt HIST_SAVE_NO_DUPS       # Don't save duplicates to history file
setopt SHARE_HISTORY           # Share history between terminals

# Directory navigation
setopt AUTO_CD
setopt CDABLE_VARS

# Vi keybindings
bindkey -v

################################[ Aliases and Functions ]####################################
# Basic aliases
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias vim='nvim'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias tmux="tmux -2"
alias .n='nvim +terminal'

# Backup related
alias backup='cp -v'

# File backup
backup_file() {
    local filename="$1"
    local backup_name="${filename}.bak_$(date +%Y%m%d)"
    cp -v "$filename" "$backup_name"
    echo "Backup created: $backup_name"
}
alias bkp=backup_file

# Directory backup
backup_dir() {
    local dirname="$1"
    local backup_name="${dirname}_backup_$(date +%Y%m%d).tar.gz"
    tar -czvf "$backup_name" "$dirname"
    echo "Backup created: $backup_name"
}
alias bkpd=backup_dir

# Docker shortcuts
alias dps='docker ps'
alias dls='docker container ls'
alias di='docker images'
alias dex='docker exec -it'
alias dcup='docker compose up -d'

# Kubernetes shortcuts
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get svc'
alias kgn='kubectl get nodes'

################################[ Version Managers ]#########################################
# pyenv setup
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# goenv setup
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
export PATH="$HOME/go/bin:$PATH"

# rbenv setup
export RBENV_ROOT="$HOME/.rbenv"
export PATH="$RBENV_ROOT/bin:$PATH"
eval "$(rbenv init -)"

# nodenv setup
export NODENV_ROOT="$HOME/.nodenv"
export PATH="$NODENV_ROOT/bin:$PATH"
eval "$(nodenv init -)"

# Rust (Cargo)
export PATH="$HOME/.cargo/bin:$PATH"

# Node Version Manager (uncomment if using)
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

#################################[ Additional Settings ]#####################################
# direnv
eval "$(direnv hook zsh)"

# Git information display
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%F{green}%b%f '

# fzf
if command -v fzf >/dev/null 2>&1; then
    source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"
    source "$(brew --prefix)/opt/fzf/shell/completion.zsh"
fi

#####################################[ Theme Settings ]#####################################
# Powerlevel10k
source ~/.powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#######################################[ Unorganized ]########################################
