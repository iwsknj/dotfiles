# 一旦シンボリックリンクをベタで書く
# TODO: 整ったらループで回すようにする

# zsh
ln -s $HOME/dotfiles/zsh/.zshrc $HOME/.zshrc
ln -s $HOME/dotfiles/zsh/.zshenv $HOME/.zshenv

# nvim
ln -s $HOME/dotfiles/nvim $HOME/.config/nvim

# starship
ln -s $HOME/dotfiles/starship/starship.toml $HOME/.config/starship.toml

# sheldon
if [ ! -d "$HOME/.config/sheldon" ]; then
  mkdir "$HOME/.config/sheldon"
fi
ln -s $HOME/dotfiles/sheldon/plugins.toml $HOME/.config/sheldon/plugins.toml
