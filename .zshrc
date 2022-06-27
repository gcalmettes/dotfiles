# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# For locally built packages
export PATH=$HOME/.local/bin:$PATH

# For local bin packages (app images, etc ..)
export PATH=$HOME/bin:$PATH

# For cargo
export PATH=$HOME/.cargo/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Go setup
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$GOBIN:$GOROOT/bin:$PATH

# Load pyenv into the shell
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export PATH="$(pyenv root)/shims:$PATH"

# Poetry setup
export PATH="$HOME/.poetry/bin:$PATH"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Kubernetes
KUBECONFIG=${KUBECONFIG:+$KUBECONFIG:}
for config_file in \
  'config' \
  'config-k3s-internal-2' \
  'config-k3s-internal-3' \
  'config-k3d-local' \
  'config-dss-ams';
do
  KUBECONFIG=${KUBECONFIG:+$KUBECONFIG:}$HOME/.kube/$config_file
done
export KUBECONFIG=$KUBECONFIG


# Git-cu (https://gitlab.com/3point2/git-cu)
export GIT_CU_DIR=$HOME/git

# for nerdctl
# nerdctl uses ${DOCKER_CONFIG}/config.json for the authentication with image registries.
export DOCKER_CONFIG=$HOME/.docker

# Set default editor to nvim
export EDITOR='nvim'

# Enabled true color support for terminals
export NVIM_TUI_ENABLE_TRUE_COLOR=1

# https://github.com/emersion/xdg-desktop-portal-wlr/wiki/%22It-doesn't-work%22-Troubleshooting-Checklist
# It's also a good idea to define XDG_CURRENT_DESKTOP=$compositor_name in the shell that you used to start
# your compositor, because some applications also benefit from having the env var set
export XDG_CURRENT_DESKTOP=sway

# Source bash completion
autoload -U bashcompinit
bashcompinit

# Activate completion for stern (https://github.com/stern/stern)
source <(stern --completion=zsh)

# User configuration
# Hide user@hostname if it's expected default user
DEFAULT_USER="gcalmettes"
prompt_context(){}

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="spaceship"

export SPACESHIP_KUBECTL_SHOW=true
export SPACESHIP_KUBECTL_VERSION_SHOW=false
export SPACESHIP_GCLOUD_SHOW=false
export SPACESHIP_PYENV_SHOW=true
export SPACESHIP_VENV_SHOW=false
export SPACESHIP_DOCKER_SHOW=false

#
##############################################################################
# History Configuration
##############################################################################
HISTSIZE=5000                 # How many lines of history to keep in memory
HISTFILE=~/.zsh_history       # Where to save history to disk
SAVEHIST=5000                 # Number of history entries to save to disk
#HISTDUP=erase                # Erase duplicates in the history file
setopt appendhistory          # Append history to the history file (no overwriting)
setopt sharehistory           # Share history across terminals
setopt incappendhistory       # Immediately append to the history file, not just when a term is killed
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it


# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"


# ZSH plugins
plugins=(kubectl)
plugins+=(git git-flow)
plugins+=(zsh-autosuggestions)


source $ZSH/oh-my-zsh.sh

# Aliases
alias vim="nvim"
alias ls="exa --icons"
alias docker="nerdctl"
alias python3='python'

# Functions
cleankube () {
  export STATUS=$1 && echo $(kubectl get ns | grep -v NAME | awk '{printf "%s\\n",$1}') | xargs -t -I % sh -c 'kubectl delete pod -n %  $(kubectl get pod -n % |  grep $STATUS | awk '"'"'{print $1}'"'"') || printf "\n***************\n** Namespace % clean\n***************\n\n"'
}
