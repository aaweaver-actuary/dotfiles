<<<<<<< HEAD
# # start with basic PATH
=======
# Add local bin folder if needed
if [ ! -d $HOME/bin ]
then
  mkdir -p $HOME/bin/
  chmod 777 $HOME/bin/
fi

# Add the folder to the PATH
>>>>>>> 0bb8bac (maybe this actually does it?)
export PATH=$PATH:$HOME/bin

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="half-life"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" "amuse" "half-life" )

# Uncomment the following line to use case-sensitive completion.
 CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
 zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
 ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
 COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
 HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
 export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

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
PROMPT="[${purple}%n%{$reset_color%}@${cyan}%M%{$reset_color%}][${limegreen}%~%{$reset_color%}]\$(virtualenv_prompt_info)\$(ruby_prompt_info)\$vcs_info_msg_0_${orange} λ%{$reset_color%} "
