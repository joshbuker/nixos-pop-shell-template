{ lib, ... }:

with lib.hm.gvariant; # Use this namespace through entire file

{
  dconf.settings = {
    # To find these, use `dconf watch /` and toggle the setting in question
    # or run `dconf dump / > dconf.settings` to see all settings.
    # Use `dconf2nix -i dconf.settings -o dconf.nix` to convert to Nix format.

    "org/gnome/desktop/wm/preferences" = {
      # https://www.reddit.com/r/gnome/comments/1emrfnt/focus_window_on_mouse_hover/
      "focus-mode" = "sloppy"; # Keep focus when hovering desktop
      # focus-mode = "mouse"; # Unfocus when hovering desktop
    };

    "org/gnome/shell/extensions/pop-shell" = {
      active-hint-border-radius = mkUint32 10;
      hint-color-rgba = "rgba(125, 108, 251, 1.0)";
    };

    "org/gnome/shell/extensions/notification-timeout" = {
      timeout = mkUint32 4000; # Notification timeout in milliseconds
      ignore-idle = true; # Always timeout even if idle
      always-normal = false; # Critical notifications time out as well
    };

    "org/gnome/shell" = {
      # Enabled Extensions
      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
        "dash-to-dock@micxgx.gmail.com"
        "pop-shell@system76.com"
        "vertical-workspaces@G-dH.github.com"
        "emoji-copy@felipeftn"
        "notification-timeout@chlumskyvaclav.gmail.com"
      ];

      welcome-dialog-last-shown-version = "48.1"; # Mute welcome dialog
    };

    "org/gnome/system/location" = {
      enabled = false; # Disable location services
    };

    "org/gnome/desktop/interface" = {
      gtk-enable-primary-paste = false; # Disable middle-click paste
    };

    "org/gnome/desktop/peripherals/mouse/accel-profile" = {
      accel-profile = "flat"; # Use flat mouse acceleration
    };

    # This is something I'll probably want to set differently for my TV computer
    # (assuming still has issues when watching shows)
    "org/gnome/desktop/session" = {
      idle-delay = mkUint32 600; # Auto-lock screen after 10 minutes of inactivity
    };

    "org/gnome/desktop/input-sources" = {
      sources = [
        (mkTuple [ "xkb" "us" ]) # Use US keyboard layout
        (mkTuple [ "ibus" "mozc-jp" ]) # Use Mozc for Japanese input
      ];

      xkb-options = ["compose:menu"];
    };

    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "suspend"; # Suspend when inactive on AC
      sleep-inactive-ac-timeout = 1200; # Suspend after 20 minutes on AC
      sleep-inactive-battery-type = "suspend"; # Suspend when inactive on battery
      sleep-inactive-battery-timeout = 1200; # Suspend after 20 minutes on battery
    };

    "org/gnome/nautilus/preferences" = {
      show-image-thumbnails = "always"; # Show image thumbnails on network shares
    };

    "org/gnome/desktop/privacy" = {
      remember-recent-files = false; # Do not remember recent files
      remove-old-trash-files = true; # Remove old trash files
      remove-old-temp-files = true; # Remove old temporary files
      old-files-age = mkUint32 14; # Remove files older than 14 days
    };
  };
}
