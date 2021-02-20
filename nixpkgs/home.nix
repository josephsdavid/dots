{ config, pkgs, ... }:
let 
  custom_config = builtins.readFile ./nvimrc;
in
  {
    nixpkgs.config={
      oraclejdk.accept_license = true;
      allowUnfree = true;
      packageOverrides = pkgs: {
        nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
          inherit pkgs;
        };
      };

    };

  #  imports = [
  #    ./nvim.nix
  #  ];
  home= {
    packages =with pkgs; [
      elementary-planner
      gnome3.nautilus
      pinta
      cawbird
      libreoffice-fresh
      zotero
      qnotero
      ncat
      weechat
      skypeforlinux
      vscode
      networkmanager_dmenu
      aws
      python37Packages.ipython
      ytop
      python37Packages.jupyterlab
      cpufrequtils
      xsel
      #processing
      gcc
      cmake
      pango
      gnumake
      usbutils
      stack
      mpv
      xorg.xdpyinfo
      (import ./vim.nix)
      tree
      maim
      slop
      xclip
      (import (fetchGit "https://github.com/haslersn/fish-nix-shell"))
      shellcheck
      #libreoffice
      obs-studio
      htop
      slop
      xdotool
      #allegro5
      #gnutls
      w3m
      wmctrl
      xsv
      fff
      firefox
      qutebrowser
      xclip
      calcurse
      signal-desktop
      slack
      ffmpeg
      playerctl
      lemonbar-xft
      python37Packages.black
      python37Packages.mypy
      zoom-us
      timewarrior
      dmenu
      bc
      libnotify
      chromium
      google-chrome
      unzip
      encryptr
      bitwarden
      evince
      go
      git-lfs
      texlive.combined.scheme-full
#pkgs.rstudio
  ];
};
gtk = {
  enable = true;
  theme = {
    package = pkgs.vimix-gtk-themes;
    name = "vimix-dark-laptop-beryl";
  };
  iconTheme = {
    package = pkgs.papirus-icon-theme;
    name = "Papirus-Dark";
  };
};
programs = {
  git = {
    enable=true;
    userName = "josephsdavid";
    userEmail = "josephsd@smu.edu";
  };
  zathura = {
    enable = true; 
  };


  fzf = {
    enable = true;
  };
};
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  services = {
    redshift = {
      enable = true;
      latitude = "32.776665";
      longitude = "-96.796989";
      brightness = {
        day = "1";
        night = "0.7";
      };
  #  temperature = {
   #   day = 6500;
    #  night = 5000;
   # };
 };

 dunst = {
   enable = true;

   settings = {
     global = {
       browser = "${config.programs.firefox.package}/bin/firefox -new-tab";
       follow = "keyboard";
       font = "Iosevka 12";
       format = "<b>%s</b>\\n%b";
       frame_color = "#555555";
       frame_width = 2;
       geometry = "500x5-5+50";
       horizontal_padding = 8;
       icon_position = "off";
       line_height = 0;
       markup = "full";
       padding = 8;
       separator_color = "frame";
       separator_height = 2;
       transparency = 0;
       word_wrap = true;
     };

     urgency_low = {
       background = "#d5d3c7";
       foreground = "#000000";
       frame_color = "#5a7493";
       timeout = 5;
     };

     urgency_normal = {
       background = "#d5d3c7";
       foreground = "#000000";
       frame_color = "#5a7493";
       timeout = 15;
     };

     urgency_critical = {
       background = "#d5d3c7";
       foreground = "#000000";
       frame_color = "#5a7493";
       timeout = 0;
     };

     shortcuts = {
       history = "ctrl+grave";
       close = "ctrl+space";
     };
     music = {
       appname = "Spotify";
       summary = "Now playing";
       urgency =  "low";
     };
   };


#      scripts = [''
#          [music]
#          appname = "Spotify";
#          summary = "Now playing";
#          urgency = "critical";
#        ''];
    };


  };
  xdg.configFile."nixpkgs/config.nix".text = ''builtins.fromJSON '''${builtins.toJSON {

    allowUnfree = true;
    oraclejdk.accept_license = true;

  }}''''' ;

}
