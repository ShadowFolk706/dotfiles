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
alias nst='sudo pmset -a disablesleep 1'
alias nsf='sudo pmset -a disablesleep 0'
export BASH_SILENCE_DEPRECATION_WARNING=1
GSzero='\e[38;2;86;64;183m'
GStwo='\e[38;2;212;104;127m'
GSnine=$(tput setaf 9)
bold=$(tput bold)
reset=$(tput sgr0)
export PS1="\[$GSzero$bold\]┌──╼ \[$reset$GStwo\]\u\[$reset\] ⇀ \[$reset$GSnine\]\W\[$reset\]\n\[$GSzero$bold\]└╼ \[$reset\]"
# export PS1="\[\[$reset$green\]\u\[$reset\] ⇀ \[$reset$red\]\W\[$reset\] "
# default
# export PS1='\u@\h:\w\$ '

export PS2='\[$orange$bold\]> '

# Setting PATH for Python 3.14
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.14/bin:${PATH}"
export PATH

# Setting PATH for Python 3.14
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.14/bin:${PATH}"
export PATH
