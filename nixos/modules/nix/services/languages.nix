{ pkgs, ... }:

{
  #############################
  ## English Keyboard Layout ##
  #############################

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  ############################
  ## Japanese Input Support ##
  ############################

  # Add support for Japanese input mode via IBus and Mozc
  i18n.inputMethod = {
    enable = true;
    type = "ibus";
    ibus.engines = [ pkgs.ibus-engines.mozc ];
  };

  # Add ibus packages required for Japanese input
  environment.systemPackages = [
    pkgs.ibus
    pkgs.ibus-engines.mozc
  ];
}
