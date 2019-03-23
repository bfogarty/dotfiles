# editor
set -x VISUAL vim
set -x EDITOR "$VISUAL"

# add ~/.bin to path
set -x PATH /usr/local/opt/python/libexec/bin $PATH
set -x PATH $PATH $HOME/.bin

# golang
set -x GOPATH $HOME/go

# use ripgrep for fzf
set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --ignore .git'
set -x RIPGREP_CONFIG_PATH "$HOME/.rgrc"

# aliases
. $HOME/.config/fish/aliases.fish
if test -e $HOME/.config/fish/work/aliases.fish
    . $HOME/.config/fish/work/aliases.fish
end

# functions
if test -d $HOME/.config/fish/functions/work
    set -a fish_function_path \
        $HOME/.config/fish/functions/work/
end

# greeting
function fish_greeting
  fish_logo
end
