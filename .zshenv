# refere:
#   https://github.com/NagayamaRyoga/dotfiles/blob/main/config/zsh/.zshenv
#   https://www.m3tech.blog/entry/dotfiles-bonsai#%E8%A8%98%E4%BA%8B%E3%81%AE%E6%A7%8B%E6%88%90

### locale ###
export LANG="en_US.UTF-8"

### XDG ###
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

### zsh ###
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

### Go ###
# export GOPATH="$XDG_DATA_HOME/go"
# export GO111MODULE="on"
