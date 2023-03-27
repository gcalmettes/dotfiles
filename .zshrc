###################################
### PATH
###################################

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
# For locally built packages
export PATH=$HOME/.local/bin:$PATH
# For local bin packages (app images, etc ..)
export PATH=$HOME/bin:$PATH
# For cargo
export PATH=$HOME/.cargo/bin:$PATH
# Poetry setup
export PATH="$HOME/.poetry/bin:$PATH"


###################################
### USER PROMPT CONFIGURATION
###################################

#### Display
# Hide user@hostname if it's expected default user
DEFAULT_USER="gcalmettes"
prompt_context(){}

#### History configuration
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


###################################
### CONFIGURATION ENV VARS
###################################

# Set default editor to nvim
export EDITOR='nvim'
# Enabled true color support for terminals
export NVIM_TUI_ENABLE_TRUE_COLOR=1
# https://github.com/emersion/xdg-desktop-portal-wlr/wiki/%22It-doesn't-work%22-Troubleshooting-Checklist
# It's also a good idea to define XDG_CURRENT_DESKTOP=$compositor_name in the shell that you used to start
# your compositor, because some applications also benefit from having the env var set
export XDG_CURRENT_DESKTOP=sway
# All go downloaded go assets in this folder
export GOPATH=$HOME/go
# Merge kubeconfig with local files
KUBECONFIG=${KUBECONFIG:+$KUBECONFIG:}
for config_file in \
  'config' \
  'config-k3s-internal-2' \
  'config-k3s-internal-3' \
  'config-k3s-local' \
  'config-dss-ams';
do
  KUBECONFIG=${KUBECONFIG:+$KUBECONFIG:}$HOME/.kube/$config_file
done
export KUBECONFIG=$KUBECONFIG
# Use new gcloud authentication with kubectl
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
# Silent direnv logs when cding into folders
export DIRENV_LOG_FORMAT=""
# Git-cu base directory (https://gitlab.com/3point2/git-cu)
export GIT_CU_DIR=$HOME/git
# For nerdctl
# nerdctl uses ${DOCKER_CONFIG}/config.json for the authentication with image registries.
export DOCKER_CONFIG=$HOME/.docker


###################################
### ZSH CONFIGURATION
###################################

#### Add plugins completions to fpath

# Source bash completion
autoload -U bashcompinit
bashcompinit

# zsh completions
fpath=($HOME/.zsh/zsh-completions/src $fpath)
# git completion (_git file)
fpath=($HOME/.zsh $fpath)
# asdf append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions for the current session
autoload -Uz compinit && compinit

#### Completion options https://thevaluable.dev/zsh-completion-guide-examples/

# Colorize completions using default `ls` colors, and color in red maching characters in partial search.
# red foreground code: 31, background cursor code black (00)
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==31=00}:${(s.:.)LS_COLORS}")';
zstyle ':completion:*' menu yes=long select

# use vim binding to navigate in the completion menu
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# can use SHIFT-TAB to navigate backward on completion suggestions
bindkey '^[[Z' reverse-menu-complete

#### kubectl completion
source <(kubectl completion zsh)

#### stern completion (https://github.com/stern/stern)
source <(stern --completion=zsh)

#### Plugins

# load asdf
. "$HOME/.asdf/asdf.sh"
# load asdf-direnv
source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"

# zsh auto suggestions
source "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"

# zsh highlightings
source "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
# activate brackets en pattern highlighters in addition to main
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
# initialize highlight patterns definitions
typeset -A ZSH_HIGHLIGHT_PATTERNS
# red background for commands starting with `rm -rf`
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')

# load starship as prompt
eval "$(starship init zsh)"


###################################
### ALIASES
###################################

alias vim="nvim"
alias ls="exa --icons"
# alias docker="nerdctl"
alias python3='python'
# # warning, this will screw up git completion
# alias git="$HOME/.config/scripts/git-warning"
alias top="btm" # cargo install bottom
alias htop="btm"
alias du="dust" # cargo install du-dust
alias cat="bat"


###################################
### CUSTOM FUNCTIONS
###################################

cleankube () {
  if [ ! -z $1 ] 
  then
      export STATUS=$1
  else
      export STATUS="completed|error|evicted|crashloop"
  fi
  echo $(kubectl get ns | grep -v NAME | awk '{printf "%s\\n",$1}') | xargs -t -I % sh -c 'kubectl delete pod -n %  $(kubectl get pod -n % |  grep -i -E "$STATUS" | awk '"'"'{print $1}'"'"') || printf "\n***************\n** Namespace % clean\n***************\n\n"'
}

#### VPN utils
vpnstart () {
 openvpn3 session-start -c $HOME/.config/openvpn/FRL207_gcalmettes@idmog.openvpn.com.ovpn
}

vpnstop () {
 sudo pkill openvpn3
}

vpnlogs () {
 openvpn3 log -c $HOME/.config/openvpn/FRL207_gcalmettes@idmog.openvpn.com.ovpn
}

#### create python venv using asdf direnv
venv () {
  local python_version
  if [ ! -z $1 ] 
  then
      python_version=$1
  else
    python_version=$(asdf current python | awk '{print $2}')
  fi
 asdf direnv local python $python_version
 echo "layout python" >> .envrc
}

#### Properly setup ssh-agent and load keys in it
# requires sudo apt install ssh-askpass
# Maintain a persistent ssh-agent across multiple
# invocations of your shell when the parent process launching them
# does not set the necessary environment variables.
AGENT_VARS_FILE="${HOME}/.ssh/agent-vars.sh"

start_agent() {
    rm -f ${AGENT_VARS_FILE}
    touch ${AGENT_VARS_FILE}
    chmod 600 ${AGENT_VARS_FILE}
    [[ -s ${AGENT_VARS_FILE} ]] && { echo "Resetting agent file failed. Non-zero length!"; exit 1; }
    ssh-agent | sed 's/^echo/#echo/' >> "${AGENT_VARS_FILE}"
    echo "New ssh-agent started"
    source ${AGENT_VARS_FILE}
    grep -slR "PRIVATE" ~/.ssh/ | xargs ssh-add
}

agent_running() {
    if [[ -n ${SSH_AUTH_SOCK} ]]; then
        ssh-add -l > /dev/null 2>&1
        case $? in
            0)  # Everything looks good
                return 0
                ;;
            1)
                echo "Looks like ssh-agent is running, but it's locked or has no key loaded"
                return 0
                ;;
        esac
    fi
    return 1
}

[[ -r ${AGENT_VARS_FILE} ]] && source ${AGENT_VARS_FILE}
agent_running || start_agent
[[ -r ${AGENT_VARS_FILE} ]] && source ${AGENT_VARS_FILE}


#### k3s/k3d
# # To start k3s with everything contained in a single folder
# startk3s () {
#   # configured to keep all its data in one folder
#   sudo $HOME/bin/k3s server  \
#   --data-dir  $HOME/k3s \
#   --config $HOME/k3s/config.yaml \
#   --disable traefik \
#   --write-kubeconfig $HOME/k3s/k3s-local.yaml

# }

# bootstrapk3s () {
#   # replace cluster name in config
#   while [[ $(grep -F "default" ~/k3s/k3s-local.yaml) ]] && [[ ! $(grep -F "k3s-local" ~/k3s/k3s-local.yaml) ]]
#     do
#       echo "Waiting for the local file to be updated ..."
#       sed -i 's/default/k3s-local/g' $HOME/k3s/k3s-local.yaml
#       sleep 1
#     done

#   echo "Switching context"
#   kubectl config use-context k3s-local

#   echo "Installing/Updating nginx ingress controller"
#   helm upgrade nginx nginx-stable/nginx-ingress --namespace ingress --create-namespace --install
# }


# If want to lazy load kubectl completion instead of loading it for every prompt
# kubectl () {
#     command kubectl $*
#     if [[ -z $KUBECTL_COMPLETE ]]
#     then
#         source <(command kubectl completion zsh)
#         KUBECTL_COMPLETE=1 
#     fi
# }
