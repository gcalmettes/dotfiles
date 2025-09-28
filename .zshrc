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
# For golang
export PATH=$PATH:/usr/local/go/bin
# All go downloaded go assets in this folder
export GOPATH=$HOME/go
export PATH="$GOPATH/bin:$PATH"
# For Krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
# For asdf
# asdf append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
export ASDF_DATA_DIR="$HOME/.asdf"
export PATH="$ASDF_DATA_DIR/shims:$PATH"

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
# Merge kubeconfig with local files
KUBECONFIG=${KUBECONFIG:+$KUBECONFIG:}
for config_file in ~/.kube/*.yaml;
do
  KUBECONFIG=${KUBECONFIG:+$KUBECONFIG:}$config_file
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

# fd integration with fzf (requires https://github.com/sharkdp/fd)
export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git'

###################################
### ZSH CONFIGURATION
###################################

#### Add plugins completions to fpath

# Source bash completion
autoload -U bashcompinit
bashcompinit

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


#### Plugins

# zsh auto suggestions
source "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# zsh highlightings
source "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# activate brackets en pattern highlighters in addition to main
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
# initialize highlight patterns definitions
typeset -A ZSH_HIGHLIGHT_PATTERNS
# red background for commands starting with `rm -rf`
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf*' 'fg=white,bold,bg=red')

# load starship as prompt
eval "$(starship init zsh)"

# direnv
eval "$(direnv hook zsh)"


###################################
### ALIASES
###################################

# Use function so local completion works and we can add flags
eza_with_icons() {
  eza $1 --icons
}

# switch programs
alias vim="nvim"
alias ls="eza_with_icons"
# alias docker="nerdctl"
alias python3='python'
# # warning, this will screw up git completion
# alias git="/usr/local/bin/git-warning"
alias top="btm" # cargo install bottom
alias htop="btm"
alias du="dust" # cargo install du-dust
alias cat="bat"
alias gitlog="git log --oneline --decorate --graph --all"
alias open="xdg-open"

# custom
# "nvim open": select file to open with nvim using rofi/dmenu search
alias nvo="fd | rofi -keep-right -dmenu -i -p FILES | xargs -I {} nvim {}"
# "search file type": search among all files of targeted type on machine, using rofi/dmenu search, can multi select and open several
alias sft="search_files_of_type"
# "search pdf": search among all pdfs on machine, using rofi/dmenu search, can multi select and open several
alias spdf="fd --type f -e pdf . $HOME | rofi -keep-right -dmenu -i -p FILES -multi-select | xargs -I {} xdg-open {}"
#remove the 256-color escapes code in a text
alias decolor="sed 's/\x1B\[[0-9;]\{1,\}[A-Za-z]//g'"
# remove all conceivable ANSI escape sequences
# sed 's/\x1B[@A-Z\\\]^_]\|\x1B\[[0-9:;<=>?]*[-!"#$%&'"'"'()*+,.\/]*[][\\@A-Z^_`a-z{|}~]//g'
# switch kube context using rofi dmenu selector
alias kswitch="kube_context_switch"
#
# alias regex="gawk 'match($0,/'$1'/, ary) {print ary['${2:-'0'}']}'"
# function regex { gawk 'match($0,/'$1'/, ary) {print ary['${2:-'0'}']}'; }
# function regex1 { gawk 'match($0,/'$1'/, ary) {print ary['${2:-'1'}']}'; }
# function regex3 { gawk 'match($0,/'$1'/, ary) {print ary[1]","ary[2]","ary[3]}'; }

function regexgenapi { gawk 'match($0,/\[([^\]]+).+(\/v1[^\s]+).+ORG:([0-9a-z{8}]+[^\]]+)\]\s\(prompt:([0-9]+)\s-\scomp:([0-9]+).*/, ary) {print ary[1]","ary[2]","ary[3]","ary[4]","ary[5]}'; }


###################################
### LAZY LOADING OF COMPLETION
###################################
# see https://frederic-hemberger.de/notes/shell/speed-up-initial-zsh-startup-with-lazy-loading/

#### kubectl
# Lazy loading Check if 'kubectl' is a command in $PATH
if [ $commands[kubectl] ]; then
  # Placeholder 'kubectl' shell function:
  # Will only be executed on the first call to 'kubectl'
  kubectl() {
    # Remove this function, subsequent calls will execute 'kubectl' directly
    unfunction "$0"
    # Load auto-completion
    source <(kubectl completion zsh)
    # Execute 'kubectl' binary
    $0 "$@"
  }
fi

#### stern
if [ $commands[stern] ]; then
  stern() {
    unfunction "$0"
    source <(stern --completion=zsh)
    $0 "$@"
  }
fi

###################################
### CUSTOM FUNCTIONS
###################################


search_files_of_type () {
  filetype=$(rofi -dmenu -show run -theme-str 'listview { enabled: false;}' -p 'Search files with extension > ')
  fd --type f -e $filetype . $HOME | rofi -keep-right -dmenu -i -p FILES -multi-select | xargs -I {} xdg-open {}
}

set_brightness () {
  value=$(rofi -dmenu -show run -theme-str 'listview { enabled: false;}' -p 'Enter brightness to set (max 255) > ')
  brightnessctl set $value
}

# switch kubecontext using rofi dmenu selector
function kube_context_switch {
  selected_context=$(kubectl config get-contexts | sed -E 's/^(\s)(.*)/.\2/' | awk '$0 !~ /none/ {print $1, $2, $3}' | column -t |  rofi -keep-right -dmenu -i -p "Kubernetes Contexts")
  switch_to=$(echo "$selected_context" | awk '{print $2}')
  kubectl config use-context "$switch_to"
}

cleanns () {
  # search all pdf files using fd and rofi
  kubectl get ns | awk '$0 !~ /NAME/ {print $1}' | rofi -keep-right -dmenu -i -p NAMESPACES -mesg "which namespace do you want to clean ?" -multi-select | xargs -I {} echo {}
}

cleankube () {
  if [ ! -z $1 ] 
  then
      export STATUS=$1
  else
      export STATUS="completed|error|evicted|crashloop|OOMkilled|Unknown|Terminated"
  fi
  echo $(kubectl get ns | grep -v NAME | awk '{printf "%s\\n",$1}') | xargs -t -I % sh -c 'kubectl delete pod -n %  $(kubectl get pod -n % |  grep -i -E "$STATUS" | awk '"'"'{print $1}'"'"') || printf "\n***************\n** Namespace % clean\n***************\n\n"'
}

#### create python venv
venv () {
  local python_version
  if [ ! -z $1 ] 
  then
    python_version=$1
  else
    python_version=$(asdf current --no-header python | awk '{print $2}')
  fi
  python_bin="$(asdf where python $python_version)/bin/python"
  echo "layout python $python_bin" >> .envrc
}

create_k3d () {
  XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-/run/user/$(id -u)}
  export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/podman/podman.sock
  export DOCKER_SOCK=$XDG_RUNTIME_DIR/podman/podman.sock
  k3d cluster create --config ~/k3d-local.config
}

#### Properly setup ssh-agent and load keys in it
# requires sudo apt install ssh-askpass (debian) | sudo dnf install openssh-askpass (fedora)
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


# ensures ctrl-e and ctrl-a are end-of-line and beginning-of-line
bindkey -e

