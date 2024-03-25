### Alias ###
alias ls='ls -G'
alias ll='ls -lh'
alias la='ll -A'
alias 1='cd ..'
alias 2='cd ../..'
alias 3='cd ../../..'
alias 4='cd ../../../..'
alias 5='cd ../../../../..'
alias 6='cd ../../../../../..'

alias su='sudo'
alias sui='sudo -i'

alias relogin='exec $SHELL -l' 	# shell relogin
alias history='history -Di'
alias ssha='ssh -A'
alias sjis='iconv -f SJIS' # Shift-jisのcsvを文字化けしないように出力

# tmux #
alias tm='tmux'
alias treload='t source ~/.tmux.conf'
alias ide="sh $HOME/dotfiles/tmux/ide.sh"
alias tcheat="cat $HOME/dotfiles/tmux/cheatSheet.md"

# Git #
alias graph="log --graph --date-order --all --pretty=format:'%h %Cred%d %Cgreen%ad %Cblue%cn %Creset%s' --date=short"

alias g='git'
alias gg='git graph'
alias gl='git log'
alias gs='git status'
alias gi='git init'

alias gb='git branch'
alias gch='git checkout'
alias gchb='git checkout -b'
alias gbd='git branch --delete'
alias gba='git branch --all'

alias ga='git add'
alias gaa='git add .'
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend -m'

alias gm='git merge'
alias gmnc='git merge --no-commit'
alias gmnf='git merge --no-ff'

alias gf='git fetch'
alias gfro='git fetch remote origin'
alias gcl='git clone'
alias gpl='git pull'

alias gps='git push'
alias gpsf='git push --force'
alias gpsa='git push --all'

alias gr='git rebase'

alias glocalname='git config --local user.name'
alias glocalemail='git config --local user.email'

# Docker #
alias d='docker'
alias dc='docker compose'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias dcps='docker compose ps'
alias dclg='docker compose logs'
alias dbash='(){ docker exec -it $1 bash}' # bash login
alias dcbash='(){ dc exec -it $1 bash}'
alias dcbashu='(){ dc exec --user $(id -u) -it $1 bash}'
alias dcexe='dc exec' # docker compose exec by default user. $1=container_name $2=command
alias dcexeu='dc exec --user $(id -u)' # docker compose exec by user specified. $1=container_name $2=command
alias dstopa='docker stop $(docker ps -q)' # stop all
alias drma='docker rm $(docker ps -aq)' # container remove all
alias dps='docker ps --format "table {{.Names}}\t{{.ID}}\t{{.Ports}}\t{{.Status}}\t{{.CreatedAt}}\t{{.RunningFor}}\t{{.Size}}"'
alias dpsa='docker ps -a --format "table {{.Names}}\t{{.ID}}\t{{.Ports}}\t{{.Status}}\t{{.CreatedAt}}\t{{.RunningFor}}\t{{.Size}} "'
alias dlogsf='() {  docker --logs --tail 10 -f $1 }'


# Neovim
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
