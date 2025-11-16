{ lib, ... }:

with lib.hm.gvariant; # Use this namespace through entire file

{
  dconf.settings = {
    # Several of the default keybindings for GNOME conflict with Pop Shell
    # keybindings, so we need to override those to `[]` to disable them.

    "org/gnome/desktop/wm/keybindings" = {
      close = lib.mkDefault ["<Super>q" "<Alt>F4"];
      minimize = lib.mkDefault ["<Super>comma"];
      toggle-maximized = lib.mkDefault ["<Super>m"];
      move-to-monitor-left = lib.mkDefault [];
      move-to-monitor-right = lib.mkDefault [];
      move-to-monitor-up = lib.mkDefault [];
      move-to-monitor-down = lib.mkDefault [];
      move-to-workspace-down = lib.mkDefault [];
      move-to-workspace-up = lib.mkDefault [];
      switch-to-workspace-down = lib.mkDefault ["<Ctrl><Super>Down"];
      switch-to-workspace-up = lib.mkDefault ["<Ctrl><Super>Up"];
      switch-to-workspace-left = lib.mkDefault [];
      switch-to-workspace-right = lib.mkDefault [];
      maximize = lib.mkDefault [];
      unmaximize = lib.mkDefault [];
    };

    "org/gnome/shell/keybindings" = {
      open-application-menu = lib.mkDefault [];
      toggle-message-tray = lib.mkDefault ["<Super>v"];
      toggle-overview = lib.mkDefault [];
    };

    "org/gnome/mutter/keybindings" = {
      toggle-tiled-left = lib.mkDefault [];
      toggle-tiled-right = lib.mkDefault [];
    };

    "org/gnome/mutter/wayland/keybindings" = {
      restore-shortcuts = lib.mkDefault [];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      screensaver = lib.mkDefault ["<Super>Escape"];
      home = lib.mkDefault ["<Super>f"];
      www = lib.mkDefault ["<Super>b"];
      terminal = lib.mkDefault ["<Super>t"];
      email = lib.mkDefault ["<Super>e"];
      rotate-video-lock-static = lib.mkDefault [];
    };

    "org/gnome/shell/extensions/pop-shell" = {
      toggle-tiling = lib.mkDefault ["<Super>y"];
      toggle-floating = lib.mkDefault ["<Super>g"];
      tile-enter = lib.mkDefault ["<Super>Return"];
      tile-accept = lib.mkDefault ["Return"];
      tile-reject = lib.mkDefault ["Escape"];
      toggle-stacking-global = lib.mkDefault ["<Super>s"];
      pop-workspace-down = lib.mkDefault ["<Shift><Super>Down" "<Shift><Super>j"];
      pop-workspace-up = lib.mkDefault ["<Shift><Super>Up" "<Shift><Super>k"];
      pop-monitor-left = lib.mkDefault ["<Shift><Super>Left" "<Shift><Super>h"];
      pop-monitor-right = lib.mkDefault ["<Shift><Super>Right" "<Shift><Super>l"];
      pop-monitor-down = lib.mkDefault [];
      pop-monitor-up = lib.mkDefault [];
      focus-left = lib.mkDefault ["<Super>Left" "<Super>h"];
      focus-down = lib.mkDefault ["<Super>Down" "<Super>j"];
      focus-up = lib.mkDefault ["<Super>Up" "<Super>k"];
      focus-right = lib.mkDefault ["<Super>Right" "<Super>l"];
    };

    # Enable tiling and window hints by default
    "org/gnome/shell/extensions/pop-shell" = {
      active-hint = lib.mkDefault true;
      tile-by-default = lib.mkDefault true;
    };

    # This is the config on pop os for using the launcher on super, but doesn't work on nix
    # "org/gnome/shell/extensions/pop-cosmic" = {
    #   overlay-key-action = "LAUNCHER";
    # };

    "org/gnome/shell/extensions/dash-to-dock" = {
      background-color = lib.mkDefault "rgb(36,31,49)";
      background-opacity = lib.mkDefault 0.8; # Semi-transparent dock
      transparency-mode = lib.mkDefault "FIXED";
      hot-keys = lib.mkDefault false; # Overlaps with Pop Shell hotkeys
      multi-monitor = lib.mkDefault true; # Enable dock on all monitors
    };

    "org/gnome/shell/extensions/vertical-workspaces" = {
      # I thought workspace wrapping would be nice, but it was annoying
      ws-switcher-wrap-around = lib.mkDefault false;
    };

    "org/gnome/shell" = {
      # Enabled Extensions
      enabled-extensions = lib.mkDefault [
        "appindicatorsupport@rgcjonas.gmail.com"
        "dash-to-dock@micxgx.gmail.com"
        "pop-shell@system76.com"
        "vertical-workspaces@G-dH.github.com"
      ];

      welcome-dialog-last-shown-version = lib.mkDefault "48.1"; # Mute welcome dialog
    };

    "org/gnome/desktop/default-applications/terminal" = {
      exec = lib.mkDefault "ghostty"; # Use Ghostty as the default terminal
      exec-arg = lib.mkDefault "--hold"; # Keep the terminal open after command execution
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = lib.mkDefault [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = lib.mkDefault "<Super>t"; # Open terminal
      command = lib.mkDefault "ghostty";
      name = lib.mkDefault "Open Terminal";
    };

    "org/gnome/desktop/interface" = {
      color-scheme = lib.mkDefault "prefer-dark"; # Prefer dark mode
      clock-format = lib.mkDefault "12h"; # Use 12-hour clock format
      clock-show-weekday = lib.mkDefault true; # Show weekday in clock
      show-battery-percentage = lib.mkDefault true; # Show battery percentage
    };

    "org/gnome/desktop/calendar" = {
      show-weekdate = lib.mkDefault true; # Show week date in calendar
    };

    "org/gtk/settings/file-chooser" = {
      clock-format = lib.mkDefault "12h"; # Use 12-hour clock format in file chooser
    };

    "org/gnome/mutter" = {
      workspaces-only-on-primary = lib.mkDefault false; # Enable workspaces on all monitors
      edge-tiling = lib.mkDefault false; # Disable edge tiling (Pop Shell handles this)
      dynamic-workspaces = lib.mkDefault true; # Enable dynamic workspaces
    };

    "org/gnome/desktop/notifications" = {
      show-in-lock-screen = lib.mkDefault true; # Show notifications on lock screen
    };

    "org/gnome/settings-daemon/plugins/power" = {
      power-button-action = lib.mkDefault "interactive"; # Shutdown on power button press
    };
  };

  # FIXME: I tried to get this working and failed, please open a PR if you know how to fix it 😂
  # gtk = {
  #   enable = true;
  #   theme = {
  #     name = "Pop";
  #     package = pkgs.pop-gtk-theme;
  #   };
  #   iconTheme = {
  #     name = "Pop";
  #     package = pkgs.pop-icon-theme;
  #   };
  # };
}
