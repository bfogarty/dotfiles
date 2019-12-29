# dotfiles

A collection of my dotfiles.

## Prerequisites

The `fish` configuration expects `fzf` to be installed before first run.

## Installation

Install `stow`. On macOS, using `brew`:

    brew install stow

Clone the repository to a subdirectory of `$HOME`.

    git clone https://github.com/bfogarty/dotfiles.git ~/.dotfiles

Install the dotfiles using `stow`:

    cd ~/.dotfiles
    stow .
