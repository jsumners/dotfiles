# Path to your oh-my-zsh installation.
export ZSH=${HOME}/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
#ZSH_THEME="blinks"
ZSH_THEME="spaceship"

SPACESHIP_CHAR_SYMBOL=❯
# Technically, I'd like to use \u2006 or \u200A as a suffix, but FiraCode
# is a monospace font. So they will render in the same width.
SPACESHIP_CHAR_SUFFIX=$(echo -e '\u200A')
SPACESHIP_PROMPT_ORDER=(
  user
  dir
  host
  git
  hg
  exec_time
  line_sep
  jobs
  exit_code
  char
)

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
ENABLE_CORRECTION="false"

## maybe switch to https://gist.github.com/vitormil/4364864 if we
## want autocorrection again

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
export FZF_BASE=$(dirname $(readlink ~/.zshrc))/fzf
plugins=(fzf git zsh-autosuggestions zsh-syntax-highlighting)

# Some history management configuration based upon
# https://web.archive.org/web/20220311224939/https://www.soberkoder.com/better-zsh-history/
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS


# User configuration
source ~/.shell_exports
source ~/.shell_aliases
source ~/.shell_functions

# See https://docs.brew.sh/Shell-Completion
# We load it here because zprofile is loaded before zshrc and we need
# all of the PATH setup before this snippet.
if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# Do this before potential overrides
source ${ZSH}/oh-my-zsh.sh

# The `g=git` alias overrides `~/bin/g`.
# Plus, I never use `g` for `git`.
unalias -m 'g'

# Check for updates after reading exports because HTTP/S proxies may be
# set via local exports.
zsh ~/.dotfiles/check_update.zsh


### Functions ###
function loadkey() {
  if [[ ! "$1" || ! "$2" ]]; then
    echo "loadkey some.host key_to_load.pub"
    return
  fi

  ssh $1 "mkdir .ssh; touch .ssh/authorized_keys; chmod og-rwx .ssh .ssh/authorized_keys"
  cat $2 | ssh $1 "cat - >> .ssh/authorized_keys"
}

function _zsh_build_help() {
  # setup help files for builtins
  # http://zsh.sourceforge.net/Doc/Release/User-Contributions.html#Accessing-On_002dLine-Help
  helpdir=$(find /opt/local -type d -path '*share/zsh/*/help' 2>/dev/null)
  if [ "${helpdir}" != "" ]; then
    HELPDIR=$helpdir
    unalias run-help
    autoload run-help
  fi
}
# asynchronus load to reduce login time
_zsh_build_help &!
