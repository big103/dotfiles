# users generic .zshrc file for zsh(1)

## Environment variable configuration
#
# LANG
#
export LANG=ja_JP.UTF-8
case ${UID} in
0)
    LANG=C
    ;;
esac


## Default shell configuration
#
# set prompt
#
autoload colors
colors
# case ${UID} in
# 0)
#     PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') %B%{${fg[yellow]}%}%/#%{${reset_color}%}%b "
#     PROMPT2="%B%{${fg[yellow]}%}%_#%{${reset_color}%}%b "
#     SPROMPT="%B%{${fg[yellow]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
#     ;;
# *)
#     PROMPT="%{${fg[cyan]}%}%/%%%{${reset_color}%} "
#     PROMPT2="%{${fg[cyan]}%}%_%%%{${reset_color}%} "
#     SPROMPT="%{${fg[cyan]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
#     [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
#         PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
#     ;;
# esac
PROMPT="%{${fg[cyan]}%}${USER} %(!.#.$) %{${reset_color}%}"
RPROMPT="%{${fg[green]}%}[ %~ ]%{${reset_color}%}"
setopt transient_rprompt


# auto change directory
#
setopt auto_cd

# auto directory pushd that you can get dirs list by cd -[tab]
#
setopt auto_pushd

# command correct edition before each completion attempt
#
setopt correct

# compacked complete list display
#
setopt list_packed

# no remove postfix slash of command line
#
setopt noautoremoveslash

# no beep sound when complete list displayed
#
setopt nolistbeep


## Keybind configuration
#
# emacs like keybind (e.x. Ctrl-a gets to line head and Ctrl-e gets
#   to end) and something additions
#
bindkey -e
bindkey "[1~" beginning-of-line # Home gets to line head
bindkey "[4~" end-of-line # End gets to line end
bindkey "[3~" delete-char # Del

#bindkey -v
#bindkey '^R' history-incremental-search-backward
#bindkey '^S' history-incremental-pattern-search-forward

# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

# reverse menu completion binded to Shift-Tab
#
bindkey "\e[Z" reverse-menu-complete


## Command history configuration
#
HISTFILE=${HOME}/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data


## Completion configuration
#
fpath=(${HOME}/.zsh/functions/Completion ${fpath})
autoload -U compinit
compinit -u


## zsh editor
#
autoload zed


## Prediction configuration
#
#autoload predict-on
#predict-off


## Alias configuration
#
# expand aliases before completing
#
setopt complete_aliases     # aliased ls needs if file/dir completions work

alias where="command -v"
alias j="jobs -l"

case "${OSTYPE}" in
freebsd*|darwin*)
    alias ls="ls -G -w"
    ;;
linux*)
    alias ls="ls --color"
    ;;
esac

alias la="ls -alh"
alias lf="ls -Fh"
alias ll="ls -lh"

alias du="du -h"
alias df="df -h"

alias su="su -l"

alias tmux='tmuxx -u'
alias vi='/usr/local/bin/vim'


## terminal configuration
#
case "${TERM}" in
screen)
    TERM=xterm
    ;;
esac

case "${TERM}" in
xterm|xterm-color|xterm-256color)
    export LSCOLORS=gxfxcxdxbxegedabagacad
    export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
kterm-color)
    stty erase '^H'
    export LSCOLORS=gxfxcxdxbxegedabagacad
    export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
kterm)
    stty erase '^H'
    ;;
cons25)
    unset LANG
    export LSCOLORS=GxFxCxdxBxegedabagacad
    export LS_COLORS='di=01;36:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;
jfbterm-color)
    export LSCOLORS=gxFxCxdxBxegedabagacad
    export LS_COLORS='di=01;36:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=;36;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;
esac

# set terminal title including current directory
#
case "${TERM}" in
xterm|xterm-color|kterm|kterm-color)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    ;;
esac


## load user .zshrc configuration file
#
[ -f ${HOME}/.zshrc.mine ] && source ${HOME}/.zshrc.mine

# android-sdk
export ANDROID_SDK_ROOT=/usr/local/opt/android-sdk
export PATH=/usr/local/bin:/usr/local/Celler/android-sdk/tools:$PATH

# Geektool calendar
export LC_TIME=C

# sqlplus
export DYLD_LIBRARY_PATH=/Applications/instantclient_10_2
export PATH=$PATH:$DYLD_LIBRARY_PATH

unset LD_LIBRARY_PATH
unset DYLD_LIBRARY_PATH

# java
export JAVA_HOME='/Library/Java/Home'
export CATALINA_HOME='/usr/local/Cellar/tomcat/7.0.41/libexec'
export JAVA_OPTS='-Dfile.encoding=UTF-8'
#export JAVA_TOOL_OPTIONS='-Dfile.encoding=SJIS'
export JAVA_TOOL_OPTIONS='-Dfile.encoding=UTF-8'

# w3mでgoogle検索
function ggl() {
local str opt
if [ $ != 0 ]; then
for i in $*; do
str="$str+$i"
done
str=`echo $str | sed 's/^\+//'`
opt='search?num=50&hl=ja&lr=lang_ja'
opt="${opt}&q=${str}"
fi
w3m http://www.google.co.jp/$opt
}

# w3mでALC検索
function alc() {
if [ $ != 0 ]; then
w3m "http://eow.alc.co.jp/$*/UTF-8/?ref=sa"
else
w3m "http://www.alc.co.jp/"
fi
}

# homebrew
export HOMEBREW_GITHUB_API_TOKEN='fa9a5f59eecfd72d27a5286ff478bc650b6ba645'

## zsh integration: any command that takes longer than 3 seconds
## https://gist.github.com/syui/7112389/raw/growl.zsh
## http://qiita.com/kazuph/items/3bfdfce6b7d02b43bf4d
#
#alias pong='perl -nle '\''print "display notification \"$_\" with title \"Terminal\""'\'' | osascript'
#
#preexec() {
#  zsh_notify_cmd=$1
#  zsh_notify_time=`date +%s`
#}
#
#precmd() {
#  if (( $? == 0 )); then
#    # message
#    zsh_notify_status=done\!\!
#  else
#    zsh_notify_status=fail
#  fi
#  if [[ "${zsh_notify_cmd}" != "" ]]; then
#    # time
#    if (( `date +%s` - ${zsh_notify_time} > 3 )); then
#      echo ${zsh_notify_cmd} ${zsh_notify_status}  | pong
#    fi
#  fi
#  zsh_notify_cmd=
#}

