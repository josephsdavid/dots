# Completely reproducible configuration files!

Requirements: A system with `nixOS` minimally installed, with the packages seen below and a working internet connection already loaded!

```nix
  environment.systemPackages = with pkgs; [
    cmake
    wget
    vim
    git
    ];
```
