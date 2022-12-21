
# Enable autocomplete for git (and others?)
autoload -Uz compinit && compinit

# Ansible macOS fork() crash workaround
# export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES 

# Customize terminal prompt
# PROMPT='%n@%m %. %% ' #Default setting
PROMPT='%F{green}%*%f:%F{blue}%~%f %% ' #Time and working dir with colour
# export PS1="%F{blue}%n%f %F{yellow}%1~ %#%f "

# Remove duplicate entries from shell history
setopt HIST_IGNORE_ALL_DUPS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
SAVEHIST=10000

# Convenient aliases
alias la='ls -a'
alias ll='ls -l'
alias code='/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code'

# Set up/down arrows to search history containing partially typed command
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# Python venv aliases
alias openstack-env='source ~/py-venvs/openstack-env/bin/activate'
alias ansible-env='source ~/py-venvs/ansible-env/bin/activate'

# Add mysql-client exe to path
export PATH=$PATH:/opt/homebrew/opt/mysql-client/bin/

# Add go's default binary location to path
export PATH=$PATH:~/go/bin
# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('/Users/scottd/.julia/juliaup/bin' $path)
export PATH

# <<< juliaup initialize <<<