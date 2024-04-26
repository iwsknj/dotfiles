if [[ "$(uname)" == "Darwin" ]]; then
  eval "$(rbenv init - zsh)"
elif [[ "$(uname)" == "Linux" ]]; then
  if [ -d "$HOME/.rbenv" ]; then
    eval "$(~/.rbenv/bin/rbenv init - zsh)"
  fi
fi


ruby_lts='3.3.0'
# 自動でrubyのバージョンを切り替える
autoload -U add-zsh-hook
load_rbenv() {
  local version_file="`pwd`/.ruby-version"
  if [ -f "$version_file" ]; then
    local version=$(cat "$version_file")
    version=${version#ruby-}
    if ! rbenv versions --bare | grep -q "^$version$"; then
      echo "Installing Ruby $version..."
      rbenv install "$version"
    fi
    rbenv local "$version"
  else
    rbenv local $ruby_lts  # デフォルトのRubyバージョンを指定
  fi
}
add-zsh-hook chpwd load_rbenv
load_rbenv

