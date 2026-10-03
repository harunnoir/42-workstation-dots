# Dotfiles

My personal dotfiles for nvim, kitty, tmux, and bash.

## Contents

```
├── nvim/          # Neovim configuration (Lua, Lazy.nvim)
├── kitty/         # Kitty terminal config + themes
├── tmux/          # Tmux configuration
├── bashrc         # Bash aliases, functions, and environment
└── install.sh     # Installation script
```

## Install

```bash
git clone https://github.com/harunnoir/42-workstation-dots.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

The script will:
- Back up existing configs to `.bak`
- Symlink each config to the correct location

## Key Features

### Neovim
- Lazy.nvim plugin manager
- LSP, debugging, git, AI, REPL integrations
- Custom keymaps (leader-based)
- 42 school specific tools

### Kitty
- Themes: farout, gruvbox_material, limei, miasma
- Optimized keybindings

### Tmux
- Prefix: `C-a`
- Vim-style pane navigation
- Session management

### Bash Utilities
| Command | Description |
|---------|-------------|
| `cf <file>` | Copy file to clipboard |
| `mkcd <dir>` | Create and enter directory |
| `extract <file>` | Extract any archive |
| `ff <name>` | Find file by name |
| `rgf <pattern>` | Search with context |
| `kl <name>` | Kill process by name |
| `duh` | Disk usage sorted |
| `serve [port]` | HTTP server |
| `wttr [loc]` | Weather |
| `gr` | Git root |
| `cpwd` | Copy pwd to clipboard |

### Git Aliases
`g`, `gs`, `ga`, `gc`, `gp`, `gl`, `gcl`

### Navigation
`c`, `..`, `...`, `....`, `-`, `~`

### Editor
`v`, `vi`, `vim` → `nvim`

## Requirements

- `nvim` ≥ 0.9
- `kitty`
- `tmux`
- `xclip` (for clipboard functions)
- `rg` (ripgrep)
- `python3`

## Update

```bash
cd ~/dotfiles
git pull
./install.sh
```