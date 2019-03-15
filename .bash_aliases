if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ls='\ls -FAh --color=always --group-directories-first --time-style=long-iso'
alias kp='ps aux | grep '
alias top='htop'
alias tree='tree -CA'
alias dv="dirs -v"
# some more ls aliases
alias ll='ls -AlF'
alias la='ls -A'
alias l='ls -CF'
alias patch='patch --follow-symlinks'

alias dir='dit'
alias parrot='echo $@'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi