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

  services.journald.settings.Journal = {
    Storage = "volatile";
    RuntimeMaxUse = "100M";
  };

  # System Maintenance
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  systemd.services.nix-gc.preStart = ''
    ${pkgs.nix}/bin/nix-env --delete-generations +5 -p /nix/var/nix/profiles/system
  '';
  nix.settings.auto-optimise-store = true;

  boot.tmp.useTmpfs = true; # /tmp → tmpfs (NixOS option)
  boot.tmp.tmpfsSize = "4G"; # Cap it
  # Nix build directory (biggest single source of temp writes)
  # By default Nix builds in /tmp, so boot.tmp.useTmpfs covers it.
  # If you want a dedicated one:
  # nix.settings.build-dir = "/tmp/nix-build";

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

  # Fix exit code 4 on WSL during switch
  services.dbus.implementation = "dbus";
}
