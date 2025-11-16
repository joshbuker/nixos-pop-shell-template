{
  home.username = "alice";
  home.homeDirectory = "/home/alice";

  imports = [
    ../../modules/home-manager
  ];

  home.file = {
    "Pictures/Wallpapers/nixos.png".source = ../../../assets/wallpapers/nixos.png;
    ".face".source = ../../../assets/profile-pictures/alice.png;
    # ".ssh/config".source = ../../../ssh/config;
  };

  dconf.settings = {
    "org/gnome/shell" = {
      # Pinned Applications
      "favorite-apps" = [
        "1password.desktop"
        "obsidian.desktop"
        "todoist.desktop"
        "proton-mail.desktop"
        "firefox.desktop"
        "discord.desktop"
        "slack.desktop"
        "signal.desktop"
        "com.github.iwalton3.jellyfin-media-player.desktop"
        "org.darktable.darktable.desktop"
        "org.kde.digikam.desktop"
        "code.desktop"
        "com.mitchellh.ghostty.desktop"
        "org.gnome.SystemMonitor.desktop"
        "org.gnome.Nautilus.desktop"
        "org.gnome.Settings.desktop"
        "steam.desktop"
      ];
    };
  };
}
