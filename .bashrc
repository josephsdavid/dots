# .bashrc
xset b off
export EDITOR="/home/david/bin/nvim"
export VISUAL="/home/david/bin/nvim"
# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc

alias g=git
alias vim="~/bin/nvim"
alias hc=herbstclient
alias ls="ls --color"
alias ytop="ytop -p -b -s"
. "$HOME/.cargo/env"

if [ -f ~/bin/sensible.bash ]; then
   source ~/bin/sensible.bash
fi
if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=0
    source $HOME/.bash-git-prompt/gitprompt.sh
    GIT_PROMPT_THEME=Minimal
fi
# Use bash-completion, if available
python ~/todo.py

eval "$(direnv hook bash)"
