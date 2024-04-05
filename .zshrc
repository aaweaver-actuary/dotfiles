# Add local bin folder if needed
if [ ! -d $HOME/bin ]
then
  mkdir -p $HOME/bin/
  chmod 777 $HOME/bin/
fi

# Add the folder just created to the PATH
export PATH=$HOME/bin:$PATH

# Add rust binaries to PATH
if [ -d $HOME/.cargo ]; then export PATH=$PATH:$HOME/.cargo/bin; fi;
if [ -d $HOME/.rustup ]; then export PATH=$PATH:$HOME/.rustup; fi;

export ZSH="$HOME/.oh-my-zsh" # Path to oh-my-zsh installation.
ZSH_THEME="half-life"
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" "amuse" "half-life" ) # Not sure if I will ever want this

CASE_SENSITIVE="true"
zstyle ':omz:update' mode auto      # update automatically without asking

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"
plugins=(git)

source $ZSH/oh-my-zsh.sh

export MANPATH="/usr/local/man:$MANPATH"

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

setopt autocd
setopt autolist
setopt interactivecomments

# Source the aliases file if it exists
[ -f ~/.zsh_aliases ] && source ~/.zsh_aliases

# == PROMPT CONFIGURATION =====================================

# prompt style and colors based on Steve Losh's Prose theme:
# https://github.com/sjl/oh-my-zsh/blob/master/themes/prose.zsh-theme
#
# vcs_info modifications from Bart Trojanowski's zsh prompt:
# http://www.jukie.net/bart/blog/pimping-out-zsh-prompt
#
# git untracked files modification from Brian Carper:
# https://briancarper.net/blog/570/git-info-in-your-zsh-prompt

#use extended color palette if available
if [[ $TERM = (*256color|*rxvt*) ]]; then
  cyan="%{${(%):-"%F{81}"}%}"
  orange="%{${(%):-"%F{166}"}%}"
  purple="%{${(%):-"%F{135}"}%}"
  hotpink="%{${(%):-"%F{161}"}%}"
  limegreen="%{${(%):-"%F{118}"}%}"
  blue="%{${(%):-"%F{blue}"}%}"
  yellow="%{${(%):-"%F{yellow}"}%}"
else
  cyan="%{${(%):-"%F{cyan}"}%}"
  orange="%{${(%):-"%F{yellow}"}%}"
  purple="%{${(%):-"%F{magenta}"}%}"
  hotpink="%{${(%):-"%F{red}"}%}"
  limegreen="%{${(%):-"%F{green}"}%}"
  blue="%{${(%):-"%F{blue}"}%}"
  yellow="%{${(%):-"%F{yellow}"}%}"
fi

autoload -Uz vcs_info
# enable VCS systems you use
zstyle ':vcs_info:*' enable git svn

# check-for-changes can be really slow.
# you should disable it, if you work with large repositories
zstyle ':vcs_info:*:prompt:*' check-for-changes true

# set formats
# %b - branchname
# %u - unstagedstr (see below)
# %c - stagedstr (see below)
# %a - action (e.g. rebase-i)
# %R - repository path
# %S - path in the repository
PR_RST="%{${reset_color}%}"
FMT_BRANCH=" on ${hotpink}%b%u%c${PR_RST}"
FMT_ACTION=" performing a ${limegreen}%a${PR_RST}"
FMT_UNSTAGED="${orange} ●"
FMT_STAGED="${limegreen} ●"

zstyle ':vcs_info:*:prompt:*' unstagedstr   "${FMT_UNSTAGED}"
zstyle ':vcs_info:*:prompt:*' stagedstr     "${FMT_STAGED}"
zstyle ':vcs_info:*:prompt:*' actionformats "${FMT_BRANCH}${FMT_ACTION}"
zstyle ':vcs_info:*:prompt:*' formats       "${FMT_BRANCH}"
zstyle ':vcs_info:*:prompt:*' nvcsformats   ""


function steeef_chpwd {
  PR_GIT_UPDATE=1
}

function steeef_preexec {
  case "$2" in
  *git*|*svn*) PR_GIT_UPDATE=1 ;;
  esac
}

function steeef_precmd {
  (( PR_GIT_UPDATE )) || return

  # check for untracked files or updated submodules, since vcs_info doesn't
  if [[ -n "$(git ls-files --other --exclude-standard 2>/dev/null)" ]]; then
    PR_GIT_UPDATE=1
    FMT_BRANCH="${PM_RST} on ${cyan}%b%u%c${hotpink} ●${PR_RST}"
  else
    FMT_BRANCH="${PM_RST} on ${cyan}%b%u%c${PR_RST}"
  fi
  zstyle ':vcs_info:*:prompt:*' formats       "${FMT_BRANCH}"

  vcs_info 'prompt'
  PR_GIT_UPDATE=
}

# vcs_info running hooks
PR_GIT_UPDATE=1

autoload -U add-zsh-hook
add-zsh-hook chpwd steeef_chpwd
add-zsh-hook precmd steeef_precmd
add-zsh-hook preexec steeef_preexec

# ruby prompt settings
ZSH_THEME_RUBY_PROMPT_PREFIX="with%F{red} "
ZSH_THEME_RUBY_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_RVM_PROMPT_OPTIONS="v g"

# virtualenv prompt settings
ZSH_THEME_VIRTUALENV_PREFIX=" with%F{red} "
ZSH_THEME_VIRTUALENV_SUFFIX="%{$reset_color%}"

setopt prompt_subst
PROMPT="[${purple}%n%{$reset_color%}@${cyan}%M%{$reset_color%}][${limegreen}%~%{$reset_color%}]\$(virtualenv_prompt_info)\$(ruby_prompt_info)\$vcs_info_msg_0_${orange}\n λ%{$reset_color%} "

# == SNOWFLAKE CONFIGURATION =====================================
export SNOWSQL_ORG="zqvxwkp"
export SNOWSQL_ACCOUNT="${SNOWSQL_ORG}-hj56993"
export SNOWSQL_USER="andyweaver"


# == SOURCE PASSWORD FILE IF IT EXISTS ============================
if [ -f ~/.passwords ]; then
  source ~/.passwords
else
  echo "No password file found - to set up passwords, create a file at ~/.passwords with the following format:"
  echo "export SNOWSQL_PWD=\"yourpassword\""
  echo "export GITHUB_TOKEN=\"yourtoken\""
  echo "etc"
  echo "Or, to shut this up create a blank ~/.passwords file."
fi

# == UTF ENCODING ENVIRONMENT VARIABLES ============================
export LANG=C.UTF-8
export LC_ALL=C.UTF-8

# == RYE CONFIGURATION =============================================
export RYE_HOME=~/.rye
source "$RYE_HOME/env"

# == ALIASES =======================================================
alias clone_dotfiles="git clone http://github.com/aaweaver-actuary/dotfiles"
