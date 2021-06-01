{ config, pkgs, ... }: {
  nixpkgs.config = {
    oraclejdk.accept_license = true;
    allowUnfree = true;
  };

  home = {
    packages = with pkgs; [
      stalonetray
      gsimplecal
      gcalcli
      conky
      xorg.transset
      texlive.combined.scheme-full
      pandoc
      thunderbird
      ueberzug
      xwinwrap
      nixfmt
      python37Packages.dbus-python
      python37Packages.pygobject3
      xorg.libXft
      xorg.libXpm
      xorg.libXfont
      sysstat
      pulsemixer
      blueberry
      polybarFull
      et
      glava
      dunst
      shfmt
      flashfocus
      discord
      netcat-openbsd
      ansifilter
      rofi
      rofi-file-browser
      betterlockscreen
      i3lock
      zotero
      nodejs-slim_latest
      weechat
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
      name = "Matcha-dark-aliz";
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
  };
  programs = {
    command-not-found.enable=true;
    git = {
      enable = true;
      lfs.enable = true;
      userName = "josephsdavid";
      userEmail = "josephsd@smu.edu";
    };
    zathura = { enable = true; };

    fzf = { enable = true; };
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  services = {
    cbatticon = {
      enable = true;
      commandCriticalLevel=''
        notify-send -u critical "Battery Critical(5%)!"
        paplay /run/current-system/sw/share/sounds/freedesktop/stereo/dialog-warning.oga
        paplay /run/current-system/sw/share/sounds/freedesktop/stereo/dialog-warning.oga
      '';
    };
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
          font = "Iosevka-Nerd-Font 13";
          format = "<b>%s</b>\\n%b";
          frame_color = "#240e28";
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
          background = "#240e28dd";
          foreground = "#d3d7cf";
          frame_color = "#2bd1fc";
          timeout = 5;
        };

        urgency_normal = {
          background = "#240e28dd";
          foreground = "#d3d7cf";
          frame_color = "#06e514";
          timeout = 15;
        };

        urgency_critical = {
          background = "#240e28dd";
          foreground = "#d3d7cf";
          frame_color = "#ff3f3f";
          timeout = 0;
        };

        shortcuts = {
          history = "ctrl+grave";
          close = "ctrl+space";
        };

        spotify = {
          appname = "*Spotify*";
          script = "/home/david/scripts/utilities/get_album_art.sh";
          urgency = "low";
        };
        #  music = {
        #    appname = "Spotify";
        #    summary = "Now playing";
        #    urgency = "low";
        #  };
      };

    };

  };
  xdg.configFile."nixpkgs/config.nix".text = "builtins.fromJSON ''${
    builtins.toJSON {

      allowUnfree = true;
      oraclejdk.accept_license = true;

    }
  }''";

}
