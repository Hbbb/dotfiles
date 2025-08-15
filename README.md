# Setup

On a new machine
```bash
git clone --bare git@github.com:hbbb/dotfiles.git $HOME/.dotfiles
alias dot='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
dot checkout   # brings files into place
dot config status.showUntrackedFiles no
```
