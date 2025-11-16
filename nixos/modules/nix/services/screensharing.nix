{ config, pkgs, lib, ... }:

{
  # Enable sound with pipewire instead so that it works with screensharing
  services.pulseaudio.enable = false;

  # Allow real-time scheduling for pipewire
  security.rtkit.enable = true;

  # Enable pipewire for screensharing support
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
