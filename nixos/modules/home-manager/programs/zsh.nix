{ config, pkgs, lib, ... }:

{
  home.file = {
    ".aliases".source = ../../../../zsh/.aliases;   # shell aliases
    ".p10k.zsh".source = ../../../../zsh/.p10k.zsh; # powerlevel10k config
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # Personally I prefer using a separate aliases file
    # shellAliases = {
    #   ll = "ls -l";
    #   edit = "sudo -e";
    #   rebuild = "sudo nixos-rebuild switch";
    # };

    history.size = 10000;
    history.ignoreAllDups = true;
    history.path = "$HOME/.zsh_history";
    history.ignorePatterns = ["rm *" "pkill *" "cp *"];

    initContent = ''
      # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      # Load aliases
      [[ ! -f ~/.aliases ]] || source ~/.aliases

      export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
      gpgconf --launch gpg-agent
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
      ];
      # theme = "powerlevel10k/powerlevel10k";
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ../../../../zsh/.p10k.zsh;
        file = "p10k.zsh";
      }
    ];
  };
}
