# editor
set -x VISUAL vim
set -x EDITOR "$VISUAL"

# add ~/.bin to path
set -x PATH $PATH $HOME/.bin

# golang
set -x GOPATH $HOME/go

# aliases
. $HOME/.config/fish/aliases.fish

# greeting
function fish_greeting
  fish_logo
end
