# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

#export PATH=$HOME/opt/anaconda3/bin:$PATH
# $HOME/Library/Python/2.7/bin:
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

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
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

plugins=(
	git
	z
	zsh-autosuggestions
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
# source ./z.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

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
alias ll="ls -al"
alias mv="mv -iv"
alias cp="cp -riv"
alias mkdir="mkdir -vp"
alias vi="nvim"
alias gacp="git add . && git commit -m sync && git push"
alias lg="lazygit"
alias gitl="git log --graph --decorate --oneline --simplify-by-decoration --all"
alias pms="pm2 start npm -- start"
alias c="clear"
alias ra='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias gu="gitup"
alias panref='pandoc -F $HOME/.config/nvim/plugged/zotcite/python3/zotref -F pandoc-citeproc --reference-doc=reference.docx'
alias proxy='export all_proxy=socks5://127.0.0.1:1086'
alias unproxy='unset all_proxy'
alias axel='axel -n 10'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias shome='ssh -Y -p 44 zhihuai1982@13715f706af888a5.sn.mynetname.net'
alias svip='ssh -Y vip24@124.77.170.70 -p 6891'
alias path='echo $PATH | tr ":" "\n"'

# powerline install
function powerline_precmd() {
    PS1="$(powerline-shell --shell zsh $?)"
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
    install_powerline_precmd
fi


# 修改默认编辑器
export EDITOR=nvim

[[ -s $HOME/.autojump/etc/profile.d/autojump.sh ]] && source $HOME/.autojump/etc/profile.d/autojump.sh

	autoload -U compinit && compinit -u

# highlighting
source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.aliyun.com/homebrew/homebrew-bottles


# zsh vim mode
#bindkey -v
#export KEYTIMEOUT=1

## Use vim keys in tab complete enu:
#bindkey -M menuselect 'h' vi-backward-char
#bindkey -M menuselect 'k' vi-up-line-or-history
#bindkey -M menuselect 'l' vi-forward-char
#bindkey -M menuselect 'j' vi-down-line-or-history
#bindkey -v '^?' backward-delete-char

## Change cursor shape for different vi modes.
#function zle-keymap-select {
  #if [[ ${KEYMAP} == vicmd ]] ||
     #[[ $1 = 'block' ]]; then
    #echo -ne '\e[1 q'
  #elif [[ ${KEYMAP} == main ]] ||
       #[[ ${KEYMAP} == viins ]] ||
       #[[ ${KEYMAP} = '' ]] ||
       #[[ $1 = 'beam' ]]; then
    #echo -ne '\e[5 q'
  #fi
#}
#zle -N zle-keymap-select
#zle-line-init() {
    #zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    #echo -ne "\e[5 q"
#}
#zle -N zle-line-init
#echo -ne '\e[5 q' # Use beam shape cursor on startup.
#preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

## Use lf to switch directories and bind it to ctrl-o
#lfcd () {
    #tmp="$(mktemp)"
    #lf -last-dir-path="$tmp" "$@"
    #if [ -f "$tmp" ]; then
        #dir="$(cat "$tmp")"
        #rm -f "$tmp"
        #[ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    #fi
#}
#bindkey -s '^o' 'lfcd\n'

## Edit line in vim with ctrl-e:
#autoload edit-command-line; zle -N edit-command-line
#bindkey '^e' edit-command-line


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


# for ZSH
case "$(uname -n)" in
  Mac*)
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/Users/zhihuai1982/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/Users/zhihuai1982/opt/anaconda3/etc/profile.d/conda.sh" ]; then
            . "/Users/zhihuai1982/opt/anaconda3/etc/profile.d/conda.sh"
        else
            export PATH="/Users/zhihuai1982/opt/anaconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<
  ;;
  tpm2*)
    NPM_PACKAGES="${HOME}/.npm-packages"

    export PATH="$PATH:$NPM_PACKAGES/bin:$HOME/.local/bin:$HOME/Biosoft/Zotero_linux-x86_64"

    # Preserve MANPATH if you already defined it somewhere in your config.
    # Otherwise, fall back to `manpath` so we can inherit from `/etc/manpath`.
    export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"

    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/home/data/vip24/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/home/data/vip24/miniconda3/etc/profile.d/conda.sh" ]; then
            . "/home/data/vip24/miniconda3/etc/profile.d/conda.sh"
        else
            export PATH="/home/data/vip24/miniconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<
  ;;
  ubuntu*)
    NPM_PACKAGES="${HOME}/.npm-packages"

    export PATH="$PATH:$NPM_PACKAGES/bin:$HOME/.local/bin"

    # Preserve MANPATH if you already defined it somewhere in your config.
    # Otherwise, fall back to `manpath` so we can inherit from `/etc/manpath`.
    export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"

    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/home/zhihuai1982/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/home/zhihuai1982/miniconda3/etc/profile.d/conda.sh" ]; then
            . "/home/zhihuai1982/miniconda3/etc/profile.d/conda.sh"
        else
            export PATH="/home/zhihuai1982/miniconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<
   ;;
esac

