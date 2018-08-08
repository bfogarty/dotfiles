# editor
set -x VISUAL vim
set -x EDITOR "$VISUAL"

# golang
set -x GOPATH $HOME/go

# aliases
. $HOME/.config/fish/aliases.fish

# greeting
function fish_greeting
  fish_logo
end
