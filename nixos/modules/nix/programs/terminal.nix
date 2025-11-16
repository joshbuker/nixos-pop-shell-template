{ pkgs, ... }:

{
  environment.systemPackages = [
    # Terminal emulators
    pkgs.unstable.ghostty # Ghostty - Minimal terminal with good defaults

    # Shells
    pkgs.bash # Widely used as default shell, included for bootstrap process
    pkgs.zsh # Posix compliant and highly customizable
    pkgs.nushell # Good for data visualization but not posix compliant

    # Prompts
    pkgs.zsh-powerlevel10k
    pkgs.meslo-lgs-nf

    # Memes
    pkgs.cmatrix
    pkgs.sl # Steam Locomotive
    pkgs.figlet

    # Network Utilities
    pkgs.iproute2
    pkgs.inetutils
    pkgs.traceroute
    pkgs.whois
    pkgs.dnsutils
    pkgs.net-snmp
    pkgs.wget

    # Manual pages for common commands
    pkgs.man-pages
    pkgs.man-pages-posix
    pkgs.tldr

    # System Monitoring
    pkgs.btop
    # Btop GPU Monitoring not working for Nvidia, requires dangerous workaround:
    # https://github.com/aristocratos/btop/issues/1040#issuecomment-3025307221
    # Using nvtop in the meantime - see nvidia.nix module

    # Other Utilities
    pkgs.fastfetch # System Information - Replacement for neofetch
    pkgs.bat # Prettier alternative to cat and less
    pkgs.yt-dlp # YouTube video downloader
    pkgs.nix-tree # Allows analyzing nix dependencies - run with `nix-tree`, search with hotkey `/`
  ];

  environment.shells = [
    pkgs.bash
    pkgs.zsh
  ];

  # Install ZSH
  programs.zsh.enable = true;

  # Set ZSH as default shell
  users.defaultUserShell = pkgs.zsh;

  # Install MTR (My Traceroute)
  programs.mtr.enable = true;
}
