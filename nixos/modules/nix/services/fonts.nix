{ pkgs, ... }:

{
  fonts = {
    # Includes useful default font packages, such as emoji support from Noto Color Emoji
    enableDefaultPackages = true;

    packages = [
      # Pop Shell Default Fonts
      pkgs.fira
      pkgs.roboto-slab
      # Fancy Icon Fonts
      pkgs.font-awesome
      pkgs.nerd-fonts.meslo-lg
      # Japanese Fonts
      pkgs.noto-fonts
      pkgs.noto-fonts-cjk-serif
      pkgs.noto-fonts-cjk-sans
      pkgs.ipafont
    ];

    # Find these with: `fc-list : family`
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [
          "Roboto Slab"
          "IPAMincho"
          "Noto Serif CJK JP"
        ];
        sansSerif = [
          "Fira Sans"
          "IPAGothic"
          "Noto Sans CJK JP"
        ];
        monospace = [
          "Fira Mono"
          "MesloLGS Nerd Font Mono"
          "Noto Sans Mono CJK JP"
        ];
      };
    };
  };
}
