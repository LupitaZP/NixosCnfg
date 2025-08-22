{ pkgs, self, inputs, ... }@args:

{
  imports = [ ./hardware-configuration.nix ];
  # Enable and config bootloader
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    # Using grub boot loader
    grub ={
      enable = true;
      device = "nodev";
      efiSupport = true;
      efiInstallAsRemovable = false;
    };
    timeout = 15;
  };
  # Enable and configure networking and firewall
  networking = {
    hostName = "RDATAA";
    networkmanager.enable = true;
    # Open ports in the firewall
    firewall = {
      allowedTCPPorts = [ 3000 5432 587 5938 57621 ];
      allowedUDPPorts = [ 5938 5353 ];
    };
  };
  services.dbus.enable = true;
  # Set your time zone.
  time.timeZone = "America/Mexico_City";
  # Select internationalization properties.
  i18n.defaultLocale = "es_MX.UTF-8";
  # Enable and config sound
  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  # Configure Bluetooth.
  hardware.bluetooth.enable = true;
  # services.blueman.enable = true;
  # List packages installed in system profile.
  environment = {
    systemPackages = with pkgs; [
      # Common packages
      aspellDicts.en
      aspellDicts.en-computers
      cachix
      gmp
      gnumake
      gparted
      hunspell
      hunspellDicts.es-mx
      hunspellDicts.en-us
      microsoft-edge
      rename
      tree
      wget
      xvkbd
      # Requisites for my work
      any-nix-shell
      curl
      direnv
      hack-font
      insomnia
      lambda-mod-zsh-theme
      nix-direnv-flakes
      nix-prefetch-git
      oh-my-zsh
      zlib
      # Requsites for doomemacs
      clang
      coreutils
      emacs
      fd
      ripgrep
      tmux
      # Requisites for PostgreSQL
      self.packages.x86_64-linux.nixos-rebuild-migration
    # Optional packages
      krita
      spotify
      obs-studio
    ];
  };
  # General Nix config
  nix = {
    settings = {
      # Nix users config
      allowed-users = [ "@wheel" "moperatico" "Lupita"];
      trusted-users = [ "root" "moperatico" "Lupita" ];
    };
  };
}
