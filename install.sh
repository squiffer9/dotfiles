#!/bin/zsh

DOTFILES_DIR="$(cd "$(dirname "${(%):-%N}")" && pwd)"

# Create symbolic-link
ln -sf "$DOTFILES_DIR/.zshrc" ~/.zshrc
ln -sf "$DOTFILES_DIR/.vimrc" ~/.vimrc
ln -sf "$DOTFILES_DIR/.tmux.conf" ~/.tmux.conf
ln -sf "$DOTFILES_DIR/.gitconfig" ~/.gitconfig
ln -sf "$DOTFILES_DIR/Brewfile" ~/Brewfile

# Install Homebrew packages
if command -v brew &>/dev/null; then
    brew bundle --file="$DOTFILES_DIR/Brewfile"
fi

echo "Dotfiles setup completed!"
