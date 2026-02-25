# -----------------------------------------------------------------------------
# Oh My Zsh
# -----------------------------------------------------------------------------
export ZSH="$HOME/.oh-my-zsh"

# Starship owns the prompt.
ZSH_THEME=""

plugins=(git)
source "$ZSH/oh-my-zsh.sh"

# -----------------------------------------------------------------------------
# Core Environment
# -----------------------------------------------------------------------------
export EDITOR="hx"
export VISUAL="hx"

#export PAGER="bat -p"
export LESS='-RX --mouse --quit-if-one-screen'
export MANWIDTH=92

export CONFIG_DIR="$HOME/.config"
export LOCAL_DIR="$HOME/.local"
export OBSIDIAN_VAULT_NAME="brain"
export OBSIDIAN_VAULT_PATH="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/brain"
export GOBIN="$HOME/.local/bin"

# FZF config
export FZF_DEFAULT_COMMAND='ag -g .'
export FZF_CTRL_T_COMMAND='fd --strip-cwd-prefix'

# -----------------------------------------------------------------------------
# PATH
# -----------------------------------------------------------------------------
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$GOBIN:$PATH"

# -----------------------------------------------------------------------------
# Aliases
# -----------------------------------------------------------------------------
alias l="ls -Ah"
alias ll="ls -lAh"
alias vimdiff="nvim -d "
alias gitd='pushd $(git rev-parse --show-toplevel)'
alias grep="grep --color=auto"
alias ssh="TERM=xterm-256color ssh"
alias markers="ag 'TODO:|FIXME:|XXX:' "
alias g="git"
alias gst="git status"
alias tf="terraform"

# Dotfiles bare-repo helper
alias dot='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# -----------------------------------------------------------------------------
# Tooling Init
# -----------------------------------------------------------------------------
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
fi

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

if command -v brew >/dev/null 2>&1; then
  eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"
fi

# -----------------------------------------------------------------------------
# Functions
# -----------------------------------------------------------------------------
install-go-tools() {
  local tools=(
    "golang.org/x/tools/gopls@latest"
    "github.com/cweill/gotests/gotests@v1.6.0"
    "github.com/josharian/impl@v1.4.0"
    "github.com/haya14busa/goplay/cmd/goplay@v1.0.0"
    "github.com/go-delve/delve/cmd/dlv@latest"
    "github.com/golangci/golangci-lint/cmd/golangci-lint@latest"
  )

  for t in "${tools[@]}"; do
    echo "Installing $t"
    go install "$t"
  done
}

daily() {
  local vault settings folder template rel abs tpl month

  vault="${OBSIDIAN_VAULT_PATH}"
  settings="$vault/.obsidian/daily-notes.json"
  folder="journal/daily"
  template=""

  [ -n "$vault" ] || { echo "Missing OBSIDIAN_VAULT_PATH"; return 1; }

  if command -v jq >/dev/null 2>&1 && [ -f "$settings" ]; then
    folder="$(jq -r '.folder // "journal/daily"' "$settings")"
    template="$(jq -r '.template // empty' "$settings")"
  fi

  rel="$folder/$(date +'%Y-%m-%d').md"
  abs="$vault/$rel"

  mkdir -p "${abs:h}" || return 1

  if [ ! -f "$abs" ]; then
    if [ -n "$template" ]; then
      tpl="$vault/$template"
      [ -f "$tpl" ] || tpl="$vault/$template.md"

      if [ -f "$tpl" ]; then
        month="$(date +%Y-%m)"
        sed "s/{{date:YYYY-MM}}/$month/g" "$tpl" > "$abs"
      else
        : > "$abs"
      fi
    else
      : > "$abs"
    fi
  fi

  if [ "$1" = "--print" ]; then
    echo "$abs"
  else
    ${EDITOR:-hx} -- "$abs"
  fi
}



# -----------------------------------------------------------------------------
# Local Overrides
# -----------------------------------------------------------------------------
[[ -f "$HOME/.local/bin/env" ]] && source "$HOME/.local/bin/env"

for extra in "$CONFIG_DIR"/zsh/.zshrc.{secrets,work}(N); do
  source "$extra"
done
