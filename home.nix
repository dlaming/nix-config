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
    git-filter-repo
    bat
    ripgrep
    fzf
    zoxide
    ffmpeg
    yt-dlp
    pueue
    fastfetch
    tmux
    fd
    fdupes
    pandoc
    btop
    dig
  ];

  programs.git = {
    enable = true;
    settings.user.name = "dlaming";
    settings.user.email = "50422489+dlaming@users.noreply.github.com";
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
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
