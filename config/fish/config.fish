
if not set -q abbrs_initialized
  set -U abbrs_initialized
  echo -n Setting abbreviations... 

  abbr g 'git'
  abbr ga 'git add'
  abbr gb 'git branch'
  abbr gbl 'git blame'
  abbr gc 'git commit -m'
  abbr gco 'git checkout'
  abbr gcp 'git cherry-pick'
  abbr gd 'git diff'
  abbr gf 'git fetch'
  abbr gl git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit
  abbr gm 'git merge'
  abbr gp 'git push'
  abbr gpl 'git pull'
  abbr gr 'git remote'
  abbr gs 'git status'
  abbr gst 'git stash'
 abbr cwtr 'curl https://wttr.in/'
 abbr hc 'herbstclient'
abbr hme 'home-manager edit'
abbr hms 'home-manager switch'
abbr vnc 'sudoedit /etc/nixos/configuration.nix'
abbr nrs 'sudo nixos-rebuild switch'
abbr m2 'ssh -CX josephsd@m2.smu.edu'
abbr gbox 'ssh -CX djosephs@172.116.176.142'
abbr updateDoom  '/home/david/.emacs.d/bin/doom -y re'
 alias f 'fff'
alias planner 'com.github.alainm23.planner'
  echo 'Done'
end

alias vim 'nvim'

fish-nix-shell --info-right | source
set fish_greeting

set PATH ~/scripts $PATH
set PATH ~/bin $PATH
set PATH ~/.local/bin $PATH
# direnv hook fish  | source
eval (direnv hook fish)
#echo "Your To-Do list"
#cat /home/david/tmp/todo
#eval (direnv hook fish)

# THEME PURE #
set fish_function_path /home/david/.config/fish/functions/theme-pure/functions/ $fish_function_path
source /home/david/.config/fish/functions/theme-pure/conf.d/pure.fish
set -U SXHKD_SHELL /usr/bin/bash

set HISTSIZE 100000
