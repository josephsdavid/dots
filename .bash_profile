# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
. "$HOME/.cargo/env"

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

case ":$PATH:" in *:/home/david/.juliaup/bin:*);; *)
    export PATH=/home/david/.juliaup/bin${PATH:+:${PATH}};;
esac

# <<< juliaup initialize <<<
