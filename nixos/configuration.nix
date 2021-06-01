# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      devices = [ "nodev" ];
      efiSupport = true;
      enable = true;
      extraEntries = ''
        menuentry "Windows" {
          insmod part_gpt
          insmod fat 
          insmod search_fs_uuid
          insmod chain
          search --fs-uuid --set=root "F072-53AC"
          chainloader /EFI/Microsoft/Boot/bootmgfw.efi
        }
      '';
      version = 2;
      theme = pkgs.nixos-grub2-theme;
    };
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;

  systemd = {

    globalEnvironment = { RADV_PERFTEST = "aco"; };

  };

  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;
  hardware.opengl = {
    enable = lib.mkDefault true;
    driSupport32Bit = config.hardware.opengl.enable;
  };

  networking.hostName = "computer"; # Define your hostname.
  networking.networkmanager.enable = true; # Enables wireless support via wpa_supplicant.

  time.timeZone = "America/Chicago";
  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    SXHKD_SHELL = "bash";
  };

  fonts.fonts = with pkgs; [
    iosevka
    nerdfonts
    fira
    cabin
    noto-fonts-cjk
    noto-fonts-emoji
    tamsyn
    tamzen
    tewi-font
    siji
    liberation_ttf
    fira-code
    fira-code-symbols
    dejavu_fonts
  ];
  environment.systemPackages = with pkgs; [
    gnome3.gnome-tweaks
    gnome-themes-extra
    gnome3.gnome-shell
    gnome3.gnome-shell-extensions
    gnome3.dconf-editor
    gnomeExtensions.dash-to-dock
    gnomeExtensions.dash-to-panel
    gnome3.gnome-calendar
    networkmanagerapplet
    glib
    glibc
    pkg-config
    cmake
    gcc
    wget
    vim
    git
    picom
    blueman
    bluez
    bluez-alsa
    bluez-tools
    superTuxKart
    direnv
    maim
    scrot
    cachix
    light
    ncdu
    ytop
    firefox
    neovim
    xclip
    evince
    bitwarden
    google-chrome
    unzip
    zoom-us
    timewarrior
    dmenu
    x11_ssh_askpass
    bc
    libnotify
    ffmpeg
    playerctl
    lemonbar-xft
    slack
    xclip
    calcurse
    qutebrowser
    xsv
    obs-studio
    htop
    shellcheck
    slop
    tree
    xsel
    networkmanager_dmenu
    libreoffice-fresh
    zotero
    pinta
    spotify
    wget
    nixos-icons
    material-design-icons
    material-icons
    killall
    termite
    lm_sensors
    cacert
    mpv
    feh
    arandr
    acpi
    neofetch
    neovim
    ranger
    sxhkd
  ];

  networking.firewall.allowedTCPPorts = [ 8008 8009 ];
  networking.firewall.allowedUDPPortRanges = [{
    from = 32768;
    to = 61000;
  }];
  networking.firewall.extraCommands =
    "iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT";

  nixpkgs.config = {
    allowUnfree = true;
    oraclejdk.accept_license = true;
  };

  programs.dconf.enable = true;
  programs.light.enable = true;
  powerManagement.cpuFreqGovernor = "powersave";
  programs.vim.defaultEditor = true;
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    extraModules = [ pkgs.pulseaudio-modules-bt ];
  };
  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluezFull;
  };

  nix = {
    buildCores = 0;
    maxJobs = 4;
    gc = {
      automatic = true;
      dates = "07:15";
      options = "--delete-older-than 3d";
    };
    readOnlyStore = false;
  };
  programs.bash = { enableCompletion = true; };
  programs.fish.enable = true;
  users.users.david = {
    isNormalUser = true;
    home = "/home/david";
    description = "David Josephs";
    extraGroups =
      [ "wheel" "power" "networkmanager" "audio" "docker" "flatpak" "video" ];
    shell = "/run/current-system/sw/bin/fish";
  };

  services = {
    gnome3.gnome-keyring.enable = true;
  # optional to use google/nextcloud calendar
    teamviewer.enable = true;
    logind.lidSwitchExternalPower = "ignore";
    openssh = {
      enable = true;
      permitRootLogin = "no";
      forwardX11 = true;
    };
    lorri.enable = true;

    printing = { enable = true; };

    upower = { enable = true; ignoreLid =  true;};

    xserver = {
      displayManager = {
        gdm.enable = true;
        gdm.wayland=false;
        #lightdm.background = /home/david/Pictures/wallpapers/cool.png;
        #lightdm.greeters = {
        #  gtk.theme.package = pkgs.matcha-gtk-theme;
        #  gtk.theme.name = "Matcha-light-aliz";
        #};
        #sddm.theme = "maya";
        #autoLogin.enable=true;
        #autoLogin.user = "david";
      };
      enable = true;
      xkbOptions = "caps:escape";

      windowManager = { herbstluftwm.enable = true; };
      desktopManager = {
        gnome3 = {
          enable = true;
        };
      };
      synaptics = {
        enable = true;
        twoFingerScroll = true;
        minSpeed = "0.5";
        maxSpeed = "3";
        accelFactor = "0.05";
        additionalOptions = ''
          Option      "VertScrollDelta"          "-111"
          Option      "HorizScrollDelta"         "-111"
        '';
      };
      libinput = { enable = false; };
    };

    picom = {
      enable = true;
      backend = "glx";
      vSync = true;
      fade = false;
      #fadeDelta=5;
      inactiveOpacity = 1.0;
      settings = {
        blur = { method = "gaussian"; };
        shadow = false;
      };
    };
  };

  hardware.cpu.amd.updateMicrocode = true;

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}

