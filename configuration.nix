# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

# Use the GRUB 2 boot loader.
boot.loader.grub.enable = true;
boot.loader.grub.version = 2;
# boot.loader.grub.efiSupport = true;
# boot.loader.grub.efiInstallAsRemovable = true;
# boot.loader.efi.efiSysMountPoint = "/boot/efi";
# Define on which hard drive you want to install Grub.
boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only


boot.kernelModules = [ 
  "coretemp"
  "kvm-intel"
  "modprobe"
];
boot.kernelPackages = pkgs.linuxPackages_latest;

networking.hostName = "dtop"; # Define your hostname.
networking.networkmanager.enable = true;

nix = {
  buildCores = 0;
  maxJobs = 6;
  gc = {
    automatic = true;
    dates = "07:15";
    options = "--delete-older-than 3d";
  };
};

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Select internationalisation properties.
# i18n = {
#   consoleFont = "Lat2-Terminus16";
#   consoleKeyMap = "us";
#   defaultLocale = "en_US.UTF-8";
# };

# Set your time zone.
time.timeZone = "America/Chicago";
environment.variables = {
  EDITOR = "vim";
  VISUAL = "vim";
};


fonts.fonts = with pkgs; [
  iosevka
  nerdfonts
  fira
  cabin
  noto-fonts-cjk
  noto-fonts-emoji
  liberation_ttf
  fira-code
  fira-code-symbols
  dejavu_fonts
  tamsyn
  noto-fonts
  lemon
];
environment.systemPackages = with pkgs; [
  openconnect
  mysql-workbench
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
  firefox
  dzen2
  qutebrowser
  spotify
  wget 
  nixos-icons
  killall
  termite
  ranger 
  vim
  gcc
  pandoc
  neofetch 
  git 
  herbstluftwm 
  compton 
  dzen2 
  feh 
  arandr
  acpi
  tmux
  imagemagick
  lm_sensors
  cacert
  mpv
  gthumb
#(let src = builtins.fetchGit "https://github.com/target/lorri"; in import src { inherit src pkgs; })
                        ];

# List packages installed in system profile. To search, run:
# $ nix search wget
# environment.systemPackages = with pkgs; [
#   wget vim
# ];

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

# List services that you want to enable:

# Enable the OpenSSH daemon.
# services.openssh.enable = true;

# Open ports in the firewall.
networking.firewall.allowedTCPPorts = [ 8008 8009 ];
networking.firewall.allowedUDPPortRanges = [ {from=32768; to=61000; } ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

# Enable CUPS to print documents.
# services.printing.enable = true;

# Enable sound.
# sound.enable = true;
# hardware.pulseaudio.enable = true;

# Enable the X11 windowing system.
# services.xserver.enable = true;
# services.xserver.layout = "us";
# services.xserver.xkbOptions = "eurosign:e";

# Enable touchpad support.
# services.xserver.libinput.enable = true;

# Enable the KDE Desktop Environment.
# services.xserver.displayManager.sddm.enable = true;
# services.xserver.desktopManager.plasma5.enable = true;

# Define a user account. Don't forget to set a password with ‘passwd’.
# users.users.guest = {
#   isNormalUser = true;
#   uid = 1000;
# };
#
nixpkgs.config = {
  allowUnfree = true;
  oraclejdk.accept_license = true;
};

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
programs.dconf.enable = true;
programs.light.enable=true;
# List services that you want to enable:
powerManagement.cpuFreqGovernor = "powersave";

sound.enable = true;
hardware.pulseaudio ={
  enable = true;
  support32Bit = true;
  extraModules = [pkgs.pulseaudio-modules-bt];
};
hardware.logitech = {
  enable = true;
  enableGraphical = true;
};
hardware.bluetooth = {
  enable = true;
  package = pkgs.bluezFull;
};
hardware.cpu.intel.updateMicrocode = true;

programs.bash = {
  enableCompletion = true;
};
programs.fish.enable=true;
programs.vim.defaultEditor = true;
users.users.david = {
  isNormalUser=true;
  home = "/home/david";
  description = "David Josephs";
  extraGroups = [ "wheel" "power" "networkmanager" "audio" "docker" "flatpak" "video"];
  shell = "/run/current-system/sw/bin/fish";
};


networking.dhcpcd.enable = true;
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
  windowManager = {
    herbstluftwm.enable = true;
    fvwm = {
      enable = true;
      gestures = true;
    };
  };
  desktopManager = {
    xfce.enable=true;
  };
  videoDrivers = [ "intel" ];
  libinput = {
    enable = true;
    naturalScrolling = false;
  };
};
compton = {
  enable = false;
  fade = false;
  inactiveOpacity = "1.0";
  shadow = false;
};
  };
# This value determines the NixOS release with which your system is to be
# compatible, in order to avoid breaking some software such as database
# servers. You should change this only after NixOS release notes say you
# should.
system.stateVersion = "20.03"; # Did you read the comment?

}
