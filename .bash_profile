PATH="/Library/Frameworks/Python.framework/Versions/3.11/bin:${PATH}"
export PATH
eval "$(/opt/homebrew/bin/brew shellenv)"
alias nv=nvim
alias n=nvim
alias config='nvim ~/.config/ghostty/config'
alias p='python3'
alias tb='python3 ~/TypingBot.py'
alias ':q'='exit'
alias c='clear'
export BASH_SILENCE_DEPRECATION_WARNING=1
green=$(tput setaf 2)
red=$(tput setaf 1)
yellow=$(tput setaf 3)
brightGreen=$(tput setaf 12)
bold=$(tput bold)
reset=$(tput sgr0)
# export PS1='\[$orange\]\u\[$reset\]\[$salmon\]@\[$red\]\W\[$reset\]\[$orange\]| '
# export PS1='\[$salmon\]\u\[$reset$brightGreen$bold\]@\[$reset$red\]\W\[$reset$orange$bold\]| \[$reset\]'
# export PS1='\[$red\]\W\[$reset$orange$bold\]|\[$reset\] '
# export PS1="\[$salmon$bold\]┌──╼\[$reset\] ⇀ \[$reset$orange\]\u\[$reset\] ⇀ \[$reset$red\]\W\[$reset\]\n\[$salmon$bold\]└╼ \[$reset\]"
export PS1="\[$yellow$bold\]┌──╼ \[$reset$green\]\u\[$reset\] ⇀ \[$reset$red\]\W\[$reset\]\n\[$yellow$bold\]└╼ \[$reset\]"
# default
# export PS1='\u@\h:\w\$ '

export PS2='\[$orange$bold\]> '
