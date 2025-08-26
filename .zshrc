# History =====================================================================
# Docs: https://zsh.sourceforge.io/Doc/Release/Options.html#History
HISTFILE=~/.local/share/zsh/history
SAVEHIST=100000 # Max entries saved to file.
HISTSIZE=100000 # Max entires for in-memory history.

setopt hist_ignore_dups  # Collapse two consecutive idential commands.
setopt hist_find_no_dups  # Ignore duplicates when searching history.
setopt share_history  # Share across concurrent sessions (append immediately, read from files, add timestamps).
setopt hist_ignore_space  # Lines that begin with space are not recorded.
setopt hist_verify  # Don't auto-execute selected history entry.
setopt hist_ignore_all_dups  # If a history entry would be duplicate, delete older copies.
setopt inc_append_history # immediately append commands to the history file

# General settings ===========================================================

# Default terminal editor
export EDITOR=hx
export VISUAL=hx

# bat highlights some languages. -p (plain) skips borders and line numbers.
export PAGER="bat -p"

# -R sends control characters to render colours, bold, etc…
# -X don't clear screen.
export LESS='-RX --mouse --quit-if-one-screen'

export MANWIDTH=92

# FZF config
export FZF_DEFAULT_COMMAND='ag -g .'  # Used by: fzf-lua (neovim plugin)
export FZF_CTRL_T_COMMAND='fd --strip-cwd-prefix'

# Convenience paths
export CONFIG_DIR="$HOME/.config"
export LOCAL_DIR="$HOME/.local"
export OBSIDIAN_VAULT_PATH="$HOME/Documents/brain"

# Convenience aliases =========================================================
alias l="ls -Ah"
alias ll="ls -lAh"

alias vimdiff="nvim -d "

# Change directory into the current repo's root. Use `popd` to jump back.
alias gitd='pushd $(git rev-parse --show-toplevel)'

alias grep="grep --color=auto"
alias ssh="TERM=xterm-256color ssh"
alias markers="ag 'TODO:|FIXME:|XXX:' "
alias g="git"
alias gst="git status"
alias tf="terraform"

alias dot="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

# Shell plugins ===============================================================

# Shell prompt
eval "$(starship init zsh)"

# z command (better cd)
eval "$(zoxide init zsh)"

# fzf
source <(fzf --zsh)

# Add ASDF shims to path
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# Add ~/.local/bin
export PATH="$HOME/.local/bin:$PATH"

# Obsidian  ===============================================================

daily() {
	local today_note="$OBSIDIAN_VAULT_PATH/daily/$(date +%F).md"
	[ -f $today_note ] || touch $today_note

	popd $OBSIDIAN_VAULT_PATH
	hx $today_note
}

# Random stuff ===============================================================

# I think this is a uv thing. I actually don't know
[[ -f "$HOME/.local/bin/env" ]] &&  . "$HOME/.local/bin/env"

# Load in 'extra' zshrc configs 
for extra in "$CONFIG_DIR"/zsh/{secrets,work}.zsh(N); do
  source "$extra"
done
