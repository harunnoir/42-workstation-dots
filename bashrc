# Prompt
PS1='\u@\h\$ '

set -o vi

# User binaries
export PATH="$HOME/bin:$HOME/.local/bin:$HOME/.opencode/bin:$PATH"

# Editor
export EDITOR=nvim
export VISUAL=nvim

# Editor aliases
alias v='nvim'
alias vi='nvim'
alias vim='nvim'

# Git shortcuts
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gcl='git clone'

# Navigation
alias c='cd'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'
alias ~='cd ~'

# Listing
alias ls='ls --color=auto -1'
alias ll='ls -lah'
alias la='ls -A'

# Safer file operations
alias cp='cp -i'
alias mv='mv -i'

alias oc='opencode'

# Reload config
alias reload='source ~/.bashrc'

# Copy file contents to clipboard
cf() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: cf <file>"
        return 1
    fi
    if [[ ! -f "$1" ]]; then
        echo "File not found: $1"
        return 1
    fi
    cat "$1" | xclip -selection clipboard
    echo "Copied $1 to clipboard"
}

# Create directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Extract various archive formats
extract() {
    if [[ -f "$1" ]]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"   ;;
            *.tar.gz)    tar xzf "$1"   ;;
            *.bz2)       bunzip2 "$1"   ;;
            *.rar)       unrar x "$1"   ;;
            *.gz)        gunzip "$1"    ;;
            *.tar)       tar xf "$1"    ;;
            *.tbz2)      tar xjf "$1"   ;;
            *.tgz)       tar xzf "$1"   ;;
            *.zip)       unzip "$1"     ;;
            *.Z)         uncompress "$1";;
            *.7z)        7z x "$1"      ;;
            *)           echo "Unknown archive: $1" ;;
        esac
    else
        echo "File not found: $1"
    fi
}

# Find file by name
ff() {
    find . -type f -name "*$1*" 2>/dev/null
}

# Grep with context and line numbers
rgf() {
    rg -n -C 2 "$1" "${2:-.}"
}

# Kill process by name
kl() {
    pkill -f "$1"
}

# Show disk usage of current directory
duh() {
    du -h --max-depth=1 | sort -hr
}

# Quick HTTP server
serve() {
    python3 -m http.server "${1:-8000}"
}

# Weather
wttr() {
    curl "wttr.in/${1:-}"
}

# Git root
gr() {
    git rev-parse --show-toplevel 2>/dev/null || echo "Not a git repo"
}

# Copy current directory path
cpwd() {
    pwd | tr -d '\n' | xclip -selection clipboard
    echo "Copied $(pwd) to clipboard"
}


export OPENAI_API_KEY=""

export USER='abait-el'
export MAIL='abait-el@student.1337.ma'

# uv
mkdir -p "$HOME/goinfre/.venv" \
         "$HOME/goinfre/.cache/uv" \
         "$HOME/goinfre/python"

export UV_PROJECT_ENVIRONMENT="$HOME/goinfre/.venv"
export UV_CACHE_DIR="$HOME/goinfre/.cache/uv"
export UV_PYTHON_INSTALL_DIR="$HOME/goinfre/python"

# Hugging Face
mkdir -p "$HOME/goinfre/.cache/huggingface"

export HF_HOME="$HOME/goinfre/.cache/huggingface"



if command -v tmux >/dev/null 2>&1 && [ -z "$TMUX" ]; then
    tmux attach || tmux new
fi
