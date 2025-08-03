export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

export POLITICKER_DIR=$HOME/code/politicker
export LOOSE_COLLECTIVE_DIR=$HOME/code/loosecollective

alias g="git"
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
alias dot='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

export EDITOR=hx

export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

source <(fzf --zsh)

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

# GOBIN path is the playground path. I put shell scripts etc in there
export GOBIN="$HOME/.config/bin"
export PATH="$GOBIN:$PATH"

flutter_bin="$HOME/.config/flutter/bin"
export PATH="$flutter_bin:$PATH"
