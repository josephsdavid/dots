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
alias j=juliacli
alias vim="~/bin/nvim"
alias hc=herbstclient
alias ls="ls --color"
alias ytop="ytop -p -b -s"
. "$HOME/.cargo/env"

if [ -f /home/david/bin/sensible.bash ]; then
   source /home/david/bin/sensible.bash
fi
if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=0
    source $HOME/.bash-git-prompt/gitprompt.sh
    GIT_PROMPT_THEME=Minimal
fi
# Use bash-completion, if available
# python ~/todo.py

eval "$(direnv hook bash)"
export PATH="$PATH:$HOME/install/julia-1.6.5-linux-x86_64/julia-1.6.5/bin"
export PATH="$PATH:$HOME/install/lua-language-server-3.2.4-linux-x64/bin/"
export PATH="$PATH:$HOME/.julia/bin/"
FD_OPTIONS="--follow --exclude .git --exclude node_modules"
# ssh-add ~/.ssh/id_ed25519



# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

case ":$PATH:" in *:/home/david/.juliaup/bin:*);; *)
    export PATH=/home/david/.juliaup/bin${PATH:+:${PATH}};;
esac

# <<< juliaup initialize <<<


#     ____      ____
#    / __/___  / __/
#   / /_/_  / / /_
#  / __/ / /_/ __/
# /_/   /___/_/ key-bindings.bash
#
# - $FZF_TMUX_OPTS
# - $FZF_CTRL_T_COMMAND
# - $FZF_CTRL_T_OPTS
# - $FZF_CTRL_R_OPTS
# - $FZF_ALT_C_COMMAND
# - $FZF_ALT_C_OPTS

# Key bindings
# ------------
__fzf_select__() {
  local cmd opts
  cmd="${FZF_CTRL_T_COMMAND:-"fd . $HOME"}"
  opts="--height ${FZF_TMUX_HEIGHT:-40%} --bind=ctrl-z:ignore --reverse $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS -m"
  eval "$cmd" |
    FZF_DEFAULT_OPTS="$opts" $(__fzfcmd) "$@" |
    while read -r item; do
      printf '%q ' "$item"  # escape special chars
    done
}

if [[ $- =~ i ]]; then

__fzfcmd() {
  [[ -n "$TMUX_PANE" ]] && { [[ "${FZF_TMUX:-0}" != 0 ]] || [[ -n "$FZF_TMUX_OPTS" ]]; } &&
    echo "fzf-tmux ${FZF_TMUX_OPTS:--d${FZF_TMUX_HEIGHT:-40%}} -- " || echo "fzf"
}

fzf-file-widget() {
  local selected="$(__fzf_select__ "$@")"
  READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
  READLINE_POINT=$(( READLINE_POINT + ${#selected} ))
}

__fzf_cd__() {
  local cmd opts dir
  cmd="${FZF_ALT_C_COMMAND:-"FZF_ALT_C_COMMAND=command fd -t d . $HOME"}"
  opts="--height ${FZF_TMUX_HEIGHT:-40%} --bind=ctrl-z:ignore --reverse $FZF_DEFAULT_OPTS $FZF_ALT_C_OPTS +m"
  dir=$(eval "$cmd" | FZF_DEFAULT_OPTS="$opts" $(__fzfcmd)) && printf 'builtin cd -- %q' "$dir"
}

__fzf_history__() {
  local output opts script
  opts="--height ${FZF_TMUX_HEIGHT:-40%} --bind=ctrl-z:ignore $FZF_DEFAULT_OPTS -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS +m --read0"
  script='BEGIN { getc; $/ = "\n\t"; $HISTCOUNT = $ENV{last_hist} + 1 } s/^[ *]//; print $HISTCOUNT - $. . "\t$_" if !$seen{$_}++'
  output=$(
    builtin fc -lnr -2147483648 |
      last_hist=$(HISTTIMEFORMAT='' builtin history 1) perl -n -l0 -e "$script" |
      FZF_DEFAULT_OPTS="$opts" $(__fzfcmd) --query "$READLINE_LINE"
  ) || return
  READLINE_LINE=${output#*$'\t'}
  if [[ -z "$READLINE_POINT" ]]; then
    echo "$READLINE_LINE"
  else
    READLINE_POINT=0x7fffffff
  fi
}

# Required to refresh the prompt after fzf
bind -m emacs-standard '"\er": redraw-current-line'

bind -m vi-command '"\C-z": emacs-editing-mode'
bind -m vi-insert '"\C-z": emacs-editing-mode'
bind -m emacs-standard '"\C-z": vi-editing-mode'

if (( BASH_VERSINFO[0] < 4 )); then
  # CTRL-T - Paste the selected file path into the command line
  bind -m emacs-standard '"\C-t": " \C-b\C-k \C-u`__fzf_select__`\e\C-e\er\C-a\C-y\C-h\C-e\e \C-y\ey\C-x\C-x\C-f"'
  bind -m vi-command '"\C-t": "\C-z\C-t\C-z"'
  bind -m vi-insert '"\C-t": "\C-z\C-t\C-z"'

  # CTRL-R - Paste the selected command from history into the command line
  bind -m emacs-standard '"\C-r": "\C-e \C-u\C-y\ey\C-u"$(__fzf_history__)"\e\C-e\er"'
  bind -m vi-command '"\C-r": "\C-z\C-r\C-z"'
  bind -m vi-insert '"\C-r": "\C-z\C-r\C-z"'
else
  # CTRL-T - Paste the selected file path into the command line
  bind -m emacs-standard -x '"\C-t": fzf-file-widget'
  bind -m vi-command -x '"\C-t": fzf-file-widget'
  bind -m vi-insert -x '"\C-t": fzf-file-widget'

  # CTRL-R - Paste the selected command from history into the command line
  bind -m emacs-standard -x '"\C-r": __fzf_history__'
  bind -m vi-command -x '"\C-r": __fzf_history__'
  bind -m vi-insert -x '"\C-r": __fzf_history__'
fi

# ALT-C - cd into the selected directory
bind -m emacs-standard '"\ec": " \C-b\C-k \C-u`__fzf_cd__`\e\C-e\er\C-m\C-y\C-h\e \C-y\ey\C-x\C-x\C-d"'
bind -m vi-command '"\ec": "\C-z\ec\C-z"'
bind -m vi-insert '"\ec": "\C-z\ec\C-z"'

_fzf_compgen_path() {
  local output
  local -i depth=1
  while
    output=$(fd -H -L -E ".git" --exact-depth "$depth" . "$1")
    
    rg -v "^\.|/\." <<<"$output"
    rg "^\.|/\." <<<"$output"

    depth+=1

    [ "$output" ]
  do true; done
}

_fzf_compgen_dir() {
  local output
  local -i depth=1
  while
    output=$(fd -H -L -E ".git" --exact-depth "$depth" -t d . "$1")

    rg -v "^\.|/\." <<<"$output"
    rg "^\.|/\." <<<"$output"

    depth+=1

    [ "$output" ]
  do true; done
}

_herbstclient_complete() {
    local IFS=$'\n'
    # do not split at =, because BASH would not split at a '='.
    COMP_WORDBREAKS=${COMP_WORDBREAKS//=}
    COMPREPLY=(
        # just call the herbstclient complete .. but without herbstclient as argument
        $(herbstclient -q complete_shell "$((COMP_CWORD-1))" "${COMP_WORDS[@]:1}")
    )
}

complete -F _herbstclient_complete -o nospace herbstclient
complete -F _herbstclient_complete -o nospace hc

export JULIA_EDITOR="nvim --server $HOME/.cache/nvim/server.pipe --remote"

fi
