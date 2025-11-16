{ pkgs, ... }:

{
  # Install various common programs
  environment.systemPackages = [
    # File Editors
    pkgs.audacity # Audio Editing
    pkgs.libreoffice # Office Suite
    pkgs.gimp3 # Image Editing
    pkgs.vidcutter # Simple Video Editing
    pkgs.musescore # Music Notation
    pkgs.darktable # RAW Photo Editing

    # Organization
    pkgs.todoist-electron # Personal Todo List
    pkgs.obsidian # Markdown Note Taking
    pkgs.digikam # Photo Management

    # Development Tools
    pkgs.arduino-ide # Arduino v2 IDE
    pkgs.vscode # Visual Studio Code IDE
    pkgs.git # Version Control

    # Media Playback
    pkgs.jellyfin-media-player
    pkgs.vlc

    # Misc Utilities
    pkgs.imagemagick
    pkgs.ffmpeg_6
    pkgs.popsicle

    # Communication
    pkgs.discord
    pkgs.slack
    pkgs.signal-desktop
    pkgs.unstable.protonmail-desktop

    # AI Tools
    pkgs.fabric-ai
  ];
}
