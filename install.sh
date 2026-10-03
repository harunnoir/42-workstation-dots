#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

link() {
    local src="$1"
    local dst="$2"
    mkdir -p "$(dirname "$dst")"
    if [[ -e "$dst" || -L "$dst" ]]; then
        echo "Backing up $dst to $dst.bak"
        mv "$dst" "$dst.bak"
    fi
    ln -sf "$src" "$dst"
    echo "Linked $src -> $dst"
}

echo "Installing dotfiles from $DOTFILES_DIR"

link "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
link "$DOTFILES_DIR/kitty" "$HOME/.config/kitty"

link "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
link "$DOTFILES_DIR/bashrc" "$HOME/.bashrc"

echo "Done! Restart your terminal or run 'tmux source ~/.tmux.conf' if tmux is running."