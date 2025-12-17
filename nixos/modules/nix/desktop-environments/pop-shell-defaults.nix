{ pkgs, ... }:

{
  # Enable the X11 windowing system
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment
  services.xserver.desktopManager.gnome.enable = true;

  # Enable GDM to handle the login and lock screens
  services.xserver.displayManager.gdm.enable = true;

  # Pop Shell system packages
  environment.systemPackages = [
    # Gnome Extensions required for Pop Shell
    pkgs.gnome-shell-extensions
    pkgs.gnomeExtensions.pop-shell
    pkgs.gnomeExtensions.dash-to-dock
    pkgs.gnomeExtensions.vertical-workspaces
    pkgs.gnomeExtensions.appindicator
    # GNOME Tweaks for additional customization
    pkgs.gnome-tweaks
    # Various Pop OS theming packages
    pkgs.pop-launcher
    pkgs.pop-gtk-theme
    pkgs.pop-icon-theme
    pkgs.pop-wallpapers
    # Utilities
    # pkgs.gnome-terminal # GNOME Terminal Emulator (Use Ghostty instead)
    pkgs.nautilus # File manager used by Pop Shell / GNOME
  ];

  # Workaround for NixOS/nixpkgs#92265
  services.xserver.desktopManager.gnome.sessionPath = [
    pkgs.gnomeExtensions.pop-shell
  ];

  # Workaround for NixOS/nixpkgs#195936
  environment.sessionVariables.GST_PLUGIN_SYSTEM_PATH_1_0 = lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" [
    pkgs.gst_all_1.gst-plugins-good
    pkgs.gst_all_1.gst-plugins-bad
    pkgs.gst_all_1.gst-plugins-ugly
    pkgs.gst_all_1.gst-plugins-libav
  ];
}
