##################################[ Environment Variables ]##################################
# ===================
# Environment Variables
# ===================
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR=nvim
export VISUAL=nvim

##################################[ Path configurations ]####################################
# ===================
# Path configurations
# ===================
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="$HOME/.cargo/bin:$PATH"  # Cargo for Rust
export PATH="$HOME/go/bin:$PATH"  # Go
export PATH="$HOME/.local/bin:$PATH"  # Path of `pip install --user`

##################################[ Aliases Configuration ]##################################
# ===================
# General
# ===================
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias vim='nvim'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias tmux="tmux -2"
alias .n='nvim +terminal'

# ===================
# Backup Aliases
# ===================
# For file
alias backup='cp -v'
backup_file() {
    local filename="$1"
    local backup_name="${filename}.bak_$(date +%Y%m%d)"
    cp -v "$filename" "$backup_name"
    echo "Backup created: $backup_name"
}
alias bkp=backup_file

# For directory
backup_dir() {
    local dirname="$1"
    local backup_name="${dirname}_backup_$(date +%Y%m%d).tar.gz"
    tar -czvf "$backup_name" "$dirname"
    echo "Backup created: $backup_name"
}
alias bkpd=backup_dir

##################################[ UNORGANIZED ]############################################

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# ----------------------------
# プロンプトの設定 (スタータス表示)
# ----------------------------
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%F{green}%b%f '

# Powerlevel10k を使用する場合
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ----------------------------
# プラグインの読み込み
# ----------------------------
# zsh-users/zsh-autosuggestions
if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# zsh-users/zsh-syntax-highlighting
if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# fzf (もしインストール済みなら)
if command -v fzf >/dev/null 2>&1; then
    source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"
    source "$(brew --prefix)/opt/fzf/shell/completion.zsh"
fi

# ----------------------------
# 補完機能とヒストリー設定
# ----------------------------
# タブ補完を有効化
autoload -Uz compinit && compinit

# ヒストリーの設定
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt APPEND_HISTORY          # 履歴を追記
setopt HIST_IGNORE_ALL_DUPS    # 重複履歴を削除
setopt HIST_IGNORE_SPACE       # スペースで始まるコマンドは履歴に残さない
setopt HIST_SAVE_NO_DUPS       # 履歴ファイルに重複を保存しない
setopt SHARE_HISTORY           # ターミナル間で履歴を共有

# ----------------------------
# その他の便利な設定
# ----------------------------
bindkey -v

# ディレクトリ移動を簡単に
setopt AUTO_CD
setopt CDABLE_VARS

# カラー出力を有効化
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# 通常ユーザーと root ユーザーの判別
if [[ $EUID -eq 0 ]]; then
    PS1='%F{red}%n@%m%f:%F{blue}%~%f # '
else
    PS1='%F{cyan}%n@%m%f:%F{blue}%~%f $ '
fi

# ----------------------------
# Zinit (Zsh プラグインマネージャー) の設定
# ----------------------------
if [[ ! -f ~/.zinit/bin/zinit.zsh ]]; then
    mkdir -p ~/.zinit && git clone https://github.com/zdharma-continuum/zinit.git ~/.zinit/bin
fi
source ~/.zinit/bin/zinit.zsh

# プラグインをロード
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

# Build flags
export LDFLAGS="-L/opt/homebrew/lib"
export CPPFLAGS="-I/opt/homebrew/include"

# ===================
# Docker Configuration
# ===================
export DOCKER_HOST="unix:///var/run/docker.sock"
export DOCKER_BUILDKIT=1

# ===================
# Node Version Manager
# ===================
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ===================
# Aliases
# ===================

# ===================
# Conda Configuration
# ===================
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('/Users/daigo/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
#    if [ -f "/Users/daigo/miniconda3/etc/profile.d/conda.sh" ]; then
#        . "/Users/daigo/miniconda3/etc/profile.d/conda.sh"
#    else
#        export PATH="/Users/daigo/miniconda3/bin:$PATH"
#    fi
#fi
#unset __conda_setup
# <<< conda initialize <
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/go/bin
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
export RBENV_ROOT="$HOME/.rbenv"
export PATH="$RBENV_ROOT/bin:$PATH"
eval "$(rbenv init -)"
export NODENV_ROOT="$HOME/.nodenv"
export PATH="$NODENV_ROOT/bin:$PATH"
eval "$(nodenv init -)"
eval "$(direnv hook zsh)"
source ~/.powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

