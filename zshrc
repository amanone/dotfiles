#
# OPTIONS
#

setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt append_history
setopt extended_history
setopt inc_append_history

#
# ENV
#

export EDITOR=vim
export PAGER=less
export LANG=en_US
export TERM=xterm-256color
export MALLOC_CHECK_=3
export PATH=$PATH:~/.rvm/bin/

export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.zshhistory

#
# ALIASES
#

alias ls='ls -h --color=auto --group-directories-first'
alias ll='ls -l --color=auto --group-directories-first'
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'
alias j='jobs'
alias z='zlock -immed'

#
# BINDS
#

bindkey -e # emacs binds
bindkey "\e[3~" delete-char # delete

# {alt,ESC}-BS to delete last part from directory name
slash-backward-kill-word() {
        local WORDCHARS="${WORDCHARS:s@/@}"
        zle backward-kill-word
}
zle -N slash-backward-kill-word
bindkey '\e^?' slash-backward-kill-word

# {alt,ESC}-e to edit command-line in editor
autoload edit-command-line
zle -N edit-command-line
bindkey '\ee' edit-command-line

#
# PROMPT
#

SGR_RST=$'%{\033[00m%}'
if [[ $UID != 0  ]]; then
    SGR_SET=$'%{\033[31m%}'
else
    SGR_SET=$'%{\033[34m%}'
fi
BLUE=$'%{\033[34m%}'
PROMPT=" ${BLUE}$ ${SGR_RST}"
JPROMPT="${SGR_SET}(${SGR_RST}%B%?%b|%j${SGR_SET})${SGR_RST}"
PPROMPT="${SGR_SET}[${SGR_RST}%40<...<%~%<<${SGR_SET}]${SGR_RST}"
RPROMPT="${JPROMPT}${PPROMPT}"

#
# COMPLETION
#

autoload -Uz compinit
compinit -i
zstyle ':completion:*:processes' command 'ps -au$USER' # kill completion
