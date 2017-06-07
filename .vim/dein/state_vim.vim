if g:dein#_cache_version != 100 | throw 'Cache loading error' | endif
let [plugins, ftplugin] = dein#load_cache_raw(['/Users/kenjiiwase/.vimrc', '/Users/kenjiiwase/dotfiles/dein/dein.toml', '/Users/kenjiiwase/dotfiles/dein/dein_lazy.toml'])
if empty(plugins) | throw 'Cache loading error' | endif
let g:dein#_plugins = plugins
let g:dein#_ftplugin = ftplugin
let g:dein#_base_path = '/Users/kenjiiwase/dotfiles/.vim/dein'
let g:dein#_runtime_path = '/Users/kenjiiwase/dotfiles/.vim/dein/.cache/.vimrc/.dein'
let g:dein#_cache_path = '/Users/kenjiiwase/dotfiles/.vim/dein/.cache/.vimrc'
let &runtimepath = '/Users/kenjiiwase/dotfiles/.vim/dein/repos/github.com/Shougo/dein.vim/,/Users/kenjiiwase/.vim,/Users/kenjiiwase/dotfiles/.vim/dein/.cache/.vimrc/.dein,/usr/local/share/vim/vimfiles,/usr/local/share/vim/vim80,/Users/kenjiiwase/dotfiles/.vim/dein/.cache/.vimrc/.dein/after,/usr/local/share/vim/vimfiles/after,/Users/kenjiiwase/.vim/after'
