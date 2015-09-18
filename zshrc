# Path to your oh-my-zsh installation.
export ZSH=${HOME}/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
#ZSH_THEME="blinks"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git git-flow macports nodejs npm)

# User configuration

# Do this before potential overrides
source ${ZSH}/oh-my-zsh.sh

### Exports ###
export LANG=en_US.UTF-8

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/texbin:/Users/jsumners/bin"
export PATH="/opt/local/bin:${PATH}"

export MANPATH="/usr/local/man:/opt/local/man:${MANPATH}"

export EDITOR='vim'
export PAGER='most'

### Aliases ###
alias pg_start='sudo su - postgres -c "/opt/local/lib/postgresql94/bin/pg_ctl start -D /opt/local/var/db/postgresql94/defaultdb -l /tmp/postgresql.log"'
alias pg_stop='sudo su - postgres -c "/opt/local/lib/postgresql94/bin/pg_ctl stop -D /opt/local/var/db/postgresql94/defaultdb"'
alias tmux='TERM=screen-256color-bce tmux -2'
alias screen='tmux'

### Functions ###
function loadkey() {
  if [[ ! "$1" || ! "$2" ]]; then
    echo "loadkey some.host key_to_load.pub"
    return
  fi

  ssh $1 "mkdir .ssh; touch .ssh/authorized_keys; chmod og-rwx .ssh .ssh/authorized_keys"
  cat $2 | ssh $1 "cat - >> .ssh/authorized_keys"
}

### Theme ###
function _get_prompt() {
  typeset p=""
  if [[ $(id -u) -eq 0 ]]; then
    p="%{%F{red}%#%f%}"
  else
    p="%{%F{002}%#%f%}"
  fi

  echo $p
}

function _git_status() {
  typeset s=""

  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    s="$(git_prompt_info)"
  fi

  echo $s
}

ZSH_THEME_GIT_PROMPT_PREFIX="%{%F{005}<git:(%F{004}%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{%F{005})>%f%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{%F{red}%}*%{%f%k%b%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

PROMPT='
%B%{%F{002}[%F{006}%n%F{002}@%F{003}%m%F{002}]%} %{%F{007}%7(c:%-3~/…/%3~:%~)%} $(_git_status)
$(_get_prompt) %b%f'

RPROMPT='%F{008}[s:%? l:%h]%f'
