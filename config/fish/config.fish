if status is-interactive
    # Commands to run in interactive sessions can go here
end
set -Ux EDITOR "/home/david/bin/nvim"
set -Ux VISUAL "/home/david/bin/nvim"
fish_add_path $HOME/.local/bin
fish_add_path $HOME/bin
fish_add_path $HOME/install/lua-language-server-3.2.4-linux-x64/bin/
fish_add_path $HOME/.julia/bin/
fish_add_path $HOME/.juliaup/bin
fish_add_path /home/david/.cargo/bin

alias g=git
alias j=juliacli
alias vim="~/bin/nvim"
alias hc=herbstclient
alias ls="ls --color"
alias ytop="ytop -p -b -s"

set -U FZF_LEGACY_KEYBINDINGS 0


direnv hook fish | source
