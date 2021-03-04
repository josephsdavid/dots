# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib,... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      devices = ["nodev"];
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
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

# discord hack
systemd = {
 # user.services.NetworkManager-wait-online.enable = false;

  globalEnvironment = {RADV_PERFTEST = "aco";};

};



hardware.enableRedistributableFirmware = true;
hardware.enableAllFirmware=true;
hardware.opengl = {
enable = lib.mkDefault true;
driSupport32Bit = config.hardware.opengl.enable;
};
  

  networking.hostName = "computer"; # Define your hostname.
  networking.networkmanager.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
time.timeZone = "America/Chicago";
environment.variables = {
  EDITOR = "nvim";
  VISUAL = "nvim";
};


fonts.fonts = with pkgs; [
  iosevka
  nerdfonts
  fira
  cabin
  noto-fonts-cjk
  noto-fonts-emoji
  tamsyn
  liberation_ttf
  fira-code
  fira-code-symbols
  dejavu_fonts
];
  # time.timeZone = "Europe/Amsterdam";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
#  networking.useDHCP = false;
#  networking.interfaces.enp2s0f0.useDHCP = true;
#  networking.interfaces.enp5s0.useDHCP = true;
#  networking.interfaces.wlp3s0.useDHCP = true;
#
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.jane = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  # };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
     wget vim git
     compton
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
   ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.

networking.firewall.allowedTCPPorts = [ 8008 8009 ];
networking.firewall.allowedUDPPortRanges = [ {from=32768; to=61000; } ];


nixpkgs.config = {
  allowUnfree = true;
  oraclejdk.accept_license = true;
};


programs.dconf.enable = true;
programs.light.enable=true;
# List services that you want to enable:
powerManagement.cpuFreqGovernor = "powersave";
programs.vim.defaultEditor=true;
sound.enable = true;
hardware.pulseaudio ={
  enable = true;
  support32Bit = true;
  extraModules = [pkgs.pulseaudio-modules-bt];
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
programs.bash = {
  enableCompletion = true;
};
programs.fish.enable = true;
users.users.david = {
  isNormalUser=true;
  home = "/home/david";
  description = "David Josephs";
  extraGroups = [ "wheel" "power" "networkmanager" "audio" "docker" "flatpak" "video"];
  shell = "/run/current-system/sw/bin/fish";
};


services = {
  gnome3.gnome-keyring.enable = true;
  teamviewer.enable = true;
  mysql = {
    enable = true;
    package = pkgs.mariadb;
  };
  logind.lidSwitchExternalPower = "ignore";
#emacs = {
# enable = true;
# };
openssh = {
  enable = true;
  permitRootLogin = "no";
  forwardX11 = true;
};
lorri.enable =true;

#flatpak = {
#  enable = true;
#};

printing = {
  enable = true;
};

upower = {
  enable = true;
};


xserver = {
  enable = true;
  xkbOptions = "caps:escape";

  windowManager = {
    herbstluftwm.enable = true;
  };
  desktopManager = {
    xfce.enable=true;
  };
  #videoDrivers = [ "????" ];
  synaptics = {
    enable = true;
    twoFingerScroll=true;
    minSpeed="0.5";
    maxSpeed = "3";
    accelFactor = "0.05";
    additionalOptions = ''
    Option      "VertScrollDelta"          "-111"
    Option      "HorizScrollDelta"         "-111"
      '';
  };
  libinput = {
    enable = false;
  #  naturalScrolling = true;
  #  accelSpeed = "7";
  };
};
compton = {
  enable = false;
  fade = false;
  inactiveOpacity = 1.0;
  shadow = false;
};
  };

hardware.cpu.amd.updateMicrocode=true;

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

