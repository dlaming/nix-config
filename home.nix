{ config, pkgs, ... }:

{
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  imports = [
    ./nvim.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    wget
    github-cli
    bat
    ripgrep
    fzf
    zoxide
    ffmpeg
    yt-dlp
    pueue
    fastfetch
    nixfmt
    tmux
    fd
    fdupes
    pandoc
    btop
  ];

  programs.git = {
    enable = true;
    settings.user.name = "dlaming";
    settings.user.email = "david@laming.me";
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      mgr = {
        show_hidden = true;
      };
    };
  };
}
