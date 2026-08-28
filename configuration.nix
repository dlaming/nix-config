{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # nixos-wsl module is now imported via flake.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Docker / Podman setup
  virtualisation.docker.enable = true;

  # Set zsh as default shell
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  programs.nix-ld.enable = true;

  # Direnv setup
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # System Maintenance
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  nix.settings.auto-optimise-store = true;

  # WSL settings
  wsl.enable = true;
  wsl.defaultUser = "nixos";
  wsl.useWindowsDriver = true;

  # GPU acceleration
  hardware.graphics.enable = true;

  # Make WSL GPU libraries discoverable system-wide (fixes nvidia-smi, etc.)
  environment.sessionVariables = {
    LD_LIBRARY_PATH = "/usr/lib/wsl/lib";
  };

  # GPU-accelerated Docker containers (Ollama, etc.)
  hardware.nvidia-container-toolkit = {
    enable = true;
    # WSL provides the driver via useWindowsDriver, not the standard NixOS nvidia module
    suppressNvidiaDriverAssertion = true;
  };
  virtualisation.docker.daemon.settings.features.cdi = true;
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "26.05";
}
