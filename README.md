# My NeoVim configs

Current `nvim` setup. Requires Packer for package management.

## From Scratch


1. Install [Chocolatey](https://chocolatey.org/install) or [Homebrew](https://brew.sh/).
2. `choco install git neovim` or `brew install git neovim`
3. Ensure NeoVim is installed: `nvim`
4. In NeoVim, run this command: `echo stdpath('config')`
5. Clone this repo into that location: `git clone git@github.com:jakofranko/nvim-config.git <path found in previous command>
6. Packer should auto-install and then install all the plugins required.
7. Quit out of NeoVim, and then restart. Voila.
