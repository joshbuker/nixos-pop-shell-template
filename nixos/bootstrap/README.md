# NixOS Bootstrap
## Why bootstrap instead of a custom ISO?

I tried to use a custom ISO installer, but the installation wizard didn't show up, and the build process was incredibly slow. Bootstrapping with a few minimal config files is trivial, so rather than dig further, I decided to just roll with a good enough solution. It also avoids the chicken and egg problem of figuring out the hardware configuration and boot config.

## Requirements

- An existing machine with your dotfiles
- Two USB sticks, one for the NixOS Installation ISO, and the other for the bootstrap files
- The target machine you're installing NixOS onto

## Usage

From an existing machine, run the `copy_bootstrap_to_usb.sh` script within a folder of your bootstrap USB drive.

```sh
~/.dotfiles/nixos/bootstrap/copy_bootstrap_to_usb.sh
```

It will prompt you where your dotfiles are, and where you'd like to copy the files to (`~/.dotfiles` and `./` respectively).

Then after installing NixOS onto your target machine, copy the bootstrap files with the `copy_bootstrap_to_host.sh` script. It will require sudo to copy `bootstrap.nix` into `/etc/nixos`.

Inside your `/etc/nixos/configuration.nix` file, add `./bootstrap.nix` to your imports:

```nix
{
  imports =
    [
      ./hardware-configuration.nix
      ./bootstrap.nix
    ];

  # Don't forget to set this! It will be important when you run the rebuild script
  networking.hostName = "your-hostname-here"; # Define your hostname.
}
```

And make sure to update your hostname to the one you want to use for this machine (so the rebuild script knows what to use).

Rebuild now that the bootstrap is in place and reboot:

```sh
sudo nixos-rebuild switch && reboot
```

## clean up and switch to `hosts/`

You should now have everything you need to pull down your dotfiles repo and switch to the permanent config.

You'll want to copy your `configuration.nix` and `hardware-configuration.nix` to your dotfiles:

```sh
mkdir -p ~/.dotfiles/nixos/hosts/{hostname}
cp /etc/nixos/configuration.nix ~/.dotfiles/nixos/hosts/{hostname}/configuration.nix
cp /etc/nixos/hardware-configuration.nix ~/.dotfiles/nixos/hosts/{hostname}/hardware-configuration.nix
```

Then you'll want to clean it up and update the imports.

Keep `networking.hostName` and anything that starts with `boot`, but remove everything else.

Update the imports to point at the NixOS modules instead of the bootstrap:

```nix
{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/nix
      ../../users
    ];
}
```

Set any custom configuration specific to the host, see examples in `hosts/` for ideas.

For example, on something with an nvidia gpu:
```nix
{
  custom.nvidia.enable = true;
}
```

These custom options are defined in the NixOS modules, you can make your own!
