
# Enable autocomplete for git (and others?)
autoload -Uz compinit && compinit

# Ansible macOS fork() crash workaround
# export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES 

# Customize terminal prompt
export PS1="%F{blue}%n%f %F{yellow}%1~ %#%f "

# Remove duplicate entries from shell history
setopt HIST_IGNORE_ALL_DUPS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
SAVEHIST=10000

# Add alias to VS code executable
alias code='/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code'

# Set up/down arrows to search history containing partially typed command
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# Python venv aliases
alias openstack-env='source ~/py-venvs/openstack/bin/activate'
alias ansible-env='source ~/py-venvs/ansible/bin/activate'
