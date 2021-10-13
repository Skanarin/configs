# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -d ~/afs/bin ] ; then
	export PATH=~/afs/bin:$PATH
fi

if [ -d ~/.local/bin ] ; then
	export PATH=~/.local/bin:$PATH
fi

export LANG=en_US.utf8
export NNTPSERVER="news.epita.fr"

export EDITOR=vim

shopt -s checkwinsize
shopt -s globstar

white="\e[0m"
b_white="\e[1;37m"
black="\e[1;30m"
pink="\e[1;35m"
green="\e[1;32m"
blue="\e[1;34m"
cyan="\e[1;36m"
red="\e[1;31m"
yellow="\e[1;33m"

beg="$white\A$black--$pink\u$black:$yellow\W$black"
end="$cyan[\j]$black-"
ret="$white\n42sh\$ "

value () {
value=$?
if [ $value -eq 0 ]; then
    echo -e $green[exit: $value]
elif [ $value -eq 148 ]; then
    echo -e $blue[exit: $value]
elif [ $value -eq 127 ]; then
    echo -e $b_white[exit: $value]
elif [ $value -eq 130 ]; then
    echo -e $yellow[exit: $value]
else
    echo -e $red[exit: $value]
fi
}

style () {
    first="${beg}$black-Bash: v\V-"
    fin="${end}\$(value)${ret}"
    printf "%s%s" "$first" "$fin"
}

PS1="$(style)"

alias ls='ls --color=always'
alias grep='grep --color -n'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export FCT=~/afs/thomasBazar/perso/
alias create="dash $FCT/creation.sh"
alias push="dash $FCT/push.sh"
alias gclean="dash $FCT/gclean.sh"
