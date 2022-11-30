
#HOST should be a Host defined in ssh/config
HOST=$1
if [ -z $HOST ]; then
    echo "No host provided"
    exit
fi

# Configure bind mounts for up/down arrows to improve shell history searching
REMOTE_HAS_INPUTRC=False
ssh -q $HOST [[ -f .inputrc ]] && REMOTE_HAS_INPUTRC=True
if [ $REMOTE_HAS_INPUTRC == False ]; then
    echo "Creating .inputrc file"
    ssh $HOST 'echo \"\\e[A\": history-search-backward >> .inputrc'
    ssh $HOST 'echo \"\\e[B\": history-search-forward >> .inputrc'
fi

echo "Installing useful packages:"
USE_DNF=False
PACKAGES="git nano tmux"
echo $PACKAGES
ssh -q $HOST "which dnf 2>/dev/null >/dev/null" && USE_DNF=True 
if [USE_DNF=False]; then
    ssh $HOST "sudo dnf -y install $PACKAGES"
else
    ssh $HOST "sudo apt update && sudo apt -y install $PACKAGES"
fi

# Configure git on remote
REMOTE_HAS_GIT_KEY=False
ssh -q $HOST [[ -f .ssh/github_id_rsa ]] && REMOTE_HAS_GIT_KEY=True
if [ $REMOTE_HAS_GIT_KEY == False ]; then 

    echo "Copying git ssh key"
    scp ~/.ssh/keys/github_id_rsa $HOST:.ssh/

    echo "Adding github.com to ssh config"
    ssh $HOST "echo -e '\nHost github.com\n HostName github.com\n IdentityFile ~/.ssh/github_id_rsa\n' >> ~/.ssh/config"
    ssh $HOST "chmod 644 .ssh/config"

    echo "Copying over .gitconfig"
    scp ~/.gitconfig $HOST:

fi

echo "Copying tmux config"
scp ~/.tmux.conf $HOST:

echo "Adding extra settings to .bashrc:"
#Increase max size of .bash_history file
ssh $HOST "echo HISTSIZE=10000 | tee -a .bashrc"
#Force history to be appended to after each command instead of on session logout
ssh $HOST "echo PROMPT_COMMAND=\'history -a\' | tee -a .bashrc"
