# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
alias zsh="$HOME/local/bin/zsh"
[ -x "/bin/zsh" ] && exec /bin/zsh

