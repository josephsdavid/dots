{ config, pkgs, ... }:
  {
    nixpkgs.config={
      oraclejdk.accept_license = true;
      allowUnfree = true;
      };


  home= {
    packages =with pkgs; [
      dunst
      shfmt
      discord
      ansifilter
      rofi
      rofi-file-browser
      betterlockscreen
      i3lock
      zotero
      nodejs-slim_latest
      weechat
      vscode
      networkmanager_dmenu
      aws
      dzen2
      cpufrequtils
      xsel
      #processing
      cmake
      gnumake
      usbutils
      mpv
      xorg.xdpyinfo
      tree
      maim
      slop
      xclip
      (import (fetchGit "https://github.com/haslersn/fish-nix-shell"))
      gnome3.nautilus
      gnome3.sushi
      shellcheck
      obs-studio
      htop
      slop
      xdotool
      w3m
      wmctrl
      xsv
      fff
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
      bitwarden
      evince
      python37
      python37Packages.virtualenv
      pipenv
  ];
};
gtk = {
  enable = true;
  theme = {
    package = pkgs.matcha-gtk-theme;
    name = "Matcha-dark-azul";
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
    screen-locker = {
      enable = true;
      inactiveInterval = 10;
      lockCmd = ''
        betterlockscreen -l dim
        '';
    };
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
       background = "#fffffa";
       foreground = "#000000";
       frame_color = "#008700";
       timeout = 5;
     };

     urgency_normal = {
       background = "#fffffa";
       foreground = "#000000";
       frame_color = "#0087af";
       timeout = 15;
     };

     urgency_critical = {
       background = "#fffffa";
       foreground = "#000000";
       frame_color = "#af0000";
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
