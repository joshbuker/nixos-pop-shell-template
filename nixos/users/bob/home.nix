{
  home.username = "bob";
  home.homeDirectory = "/home/bob";

  imports = [
    ../../modules/home-manager
  ];

  home.file = {
    "Pictures/Wallpapers/nixos.png".source = ../../../assets/wallpapers/nixos.png;
    ".face".source = ../../../assets/profile-pictures/bob.png;
  };

  dconf.settings = {
    "org/gnome/shell" = {
      # Pinned Applications
      "favorite-apps" = [
        "1password.desktop"
        "obsidian.desktop"
        "todoist.desktop"
        "proton-mail.desktop"
        "google-chrome.desktop"
        "slack.desktop"
        "discord.desktop"
        # WhatsApp
        "code.desktop"
        "com.mitchellh.ghostty.desktop"
        "claude.desktop"
        "org.gnome.SystemMonitor.desktop"
        "org.gnome.Nautilus.desktop"
        "org.gnome.Settings.desktop"
      ];
    };
  };
}
