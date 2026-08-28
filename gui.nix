{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    google-chrome
    mpv
    obs-studio
    spotify
    discord
    obsidian
    ghostty
    readest
    stremio-linux-shell
    steam
    qbittorrent
    localsend
  ];
}
