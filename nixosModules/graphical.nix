{ config, pkgs, ... }:

{
  services = {
  # Enable the X11 windowing system.
    xserver = {
      enable = true;
    # Configure keymap in X11
      xkb = {
        layout = "us";
        variant = "altgr-intl";
      };
    };
  # Enable the Desktop Environment.
    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
      };
      defaultSession = "plasma";
    # Enable automatic login for the user.
      autoLogin = {
        enable = true;
        user = "moperatico";
      };
    };
    desktopManager.plasma6.enable = true;
  };
  # Enable brightness monitoring
  programs.light.enable = true;
}
