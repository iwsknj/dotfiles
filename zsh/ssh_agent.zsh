# ssh-agent がログイン時に起動されるようにする
if [ -z "$SSH_AUTH_SOCK" ]; then
   # Check for a currently running instance of the agent
   RUNNING_AGENT="`ps -ax | grep 'ssh-agent -s' | grep -v grep | wc -l | tr -d '[:space:]'`"
   if [ "$RUNNING_AGENT" = "0" ]; then
        # Launch a new instance of the agent
        ssh-agent -s &> $HOME/.ssh/ssh-agent
   fi
   eval `cat $HOME/.ssh/ssh-agent`
fi

ssh-add $HOME/.ssh/github/github_id_ed25519

# 以下のようにすると、ssh-agent が起動していない場合に、起動して追加することができる
# eval "$(ssh-agent -s)"
# ssh-add ~/.ssh/github/github_id_ed25519
