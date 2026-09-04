{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "z"
      ];
    };

    shellAliases = {
      dev = "nix develop -c zsh";
      pay = "pueue add yt-dlp --no-playlist --cookies-from-browser chrome";
      gitacp = "git add -A && git commit -am. && git push";
      nixacp = "f() { git -C /etc/nixos add . && git -C /etc/nixos commit -m \"$1\" && git -C /etc/nixos push; }; f";
      sysupdate = "nix flake update --flake /etc/nixos";
      sysupgrade = "nix flake update --flake /etc/nixos && sudo nixos-rebuild switch --flake /etc/nixos#nixos";
      sysrebuild = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
      systest = "sudo nixos-rebuild test --flake /etc/nixos#nixos";
    };

    initContent = ''
      # Pure prompt initialization
      autoload -U promptinit; promptinit
      prompt pure

      # Custom timezsh function
      timezsh() {
        shell=''${1-$SHELL}
        for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
      }
    '';
  };

  # Extra shell utilities connected to Zsh
  home.packages = with pkgs; [
    pure-prompt
  ];

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

}
