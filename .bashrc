# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PROMPT_COMMAND=__prompt_command

__prompt_command() {
    local EXIT="$?"                # This needs to be first
    PS1=""

    #Color \[ \]  needed
    local blk='\[\033[01;30m\]'   # Black
    local red='\[\033[01;31m\]'   # Red
    local grn='\[\033[01;32m\]'   # Green
    local ylw='\[\033[01;33m\]'   # Yellow
    local blu='\[\033[01;34m\]'   # Blue
    local pur='\[\033[01;35m\]'   # Purple
    local cyn='\[\033[01;36m\]'   # Cyan
    local wht='\[\033[01;37m\]'   # White
    local clr='\[\033[0m\]'      # Reset

    PS1+="${grn}\u${clr}"

    if [ $EXIT != 0 ]; then
        PS1+="${red}"
    fi

    PS1+="@${clr}\h ${blu}\${PWD/'/home/matteo'/'~'}${clr}${ylw}\$${clr} "
    PS2="\[\033[1m\]\[\033[33m\]> \[\033[0m\]"
}


#Alias
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias paru-broken='paru -Qk 2>/dev/null | grep -v " 0 " | cut -d ":" -f 1'
alias fix-broken='paru-broken | { res=""; while read -r p; do res="$p $res"; done; paru -S $res --overwrite="*" --noconfirm; }'
alias paru-rm-lock='sudo rm -f /var/lib/pacman/db.lck'
alias paru-list-useless='paru -Runsc $(paru -Qdttq)'
alias logout-kde='qdbus org.kde.Shutdown /Shutdown logout'
#Changed app
alias calc='bc'
alias neofetch='fastfetch'
##Git alias
alias gs='git status'
alias gd='git diff'
alias gl='git log'
alias gb='git branch'
alias gcom='git commit -m'
alias gcomA='git add -A && git commit -m'
alias gadd='git add'
alias gpush='git push'
alias gpull='git pull'

#History setup
HISTCONTROL=ignorespace:erasedups
HISTTIMEFORMAT="%F %T "
HISTSIZE=2000
HISTFILESIZE=2000
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
# Ctrl + R for search in command
# Ctrl + C to remove

#Extra autocomplete
complete -cf sudo paru pacman
complete -c man

#Exports
export EDITOR=nano
export PATH=$PATH:~/.local/bin
export XDG_CONFIG_HOME=~/.config

#Other
bind TAB:menu-complete

#Source (already source autocompletition)

#Shortcut
## Use Ctrl+u to delete up to a point
