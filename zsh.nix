{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 5000;
      save = 5000;
      path = "$HOME/.zsh_history";
      ignoreAllDups = true;
      share = true;
    };

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
      sysupdate = "nix flake update --flake /etc/nixos";
      sysupgrade = "nix flake update --flake /etc/nixos && sudo nixos-rebuild switch --flake /etc/nixos#nixos";
      sysrebuild = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
      systest = "sudo nixos-rebuild test --flake /etc/nixos#nixos";
      nixgc = "sudo nix-collect-garbage --delete-older-than 7d";
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
      gitacp() { 
        git add -A &&
        git commit --allow-empty-message -m "$*" &&
        git push
      }
      nixacp() {
        git -C /etc/nixos add -A &&
        git -C /etc/nixos commit --allow-empty-message -m "$*" &&
        git -C /etc/nixos push
      }
      githubclone() {
        local url="$1"
        local repo owner

        if [[ "$url" =~ 'github\.com[:/]([^/]+)/([^/]+?)(\.git)?$' ]]; then
          owner="''${match[1]}"
          repo="''${match[2]}"
          repo="''${repo%.git}"

          mkdir -p "$HOME/code/$owner"
          git clone "$url" "$HOME/code/$owner/$repo"
        else
          git clone "$@"
        fi
      }
      reposearch() {
        local repo
        repo=$(find "$HOME/code" -mindepth 2 -maxdepth 2 -type d 2>/dev/null |
          fzf --query="$1") || return
        cd "$repo"
      }
    '';
  };

  # Extra shell utilities connected to Zsh
  home.packages = with pkgs; [
    pure-prompt
  ];
}
