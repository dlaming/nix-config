{ pkgs, inputs, ... }:
{
  programs.nixvim = {
    enable = true;
    nixpkgs.source = inputs.nixpkgs;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    #colorschemes.tokyonight.enable = true;

    globals.mapleader = " ";

    opts = {
      number = true;
      relativenumber = true;
      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
      termguicolors = true;
    };

    plugins = {
      telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>fg" = "live_grep";
          "<leader>fb" = "buffers";
        };
      };

      lualine.enable = true;
      neo-tree.enable = true;

      treesitter = {
        enable = true;
        settings.ensure_installed = [
          "c"
          "cpp"
          "lua"
          "nix"
          "html"
          "vim"
          "vimdoc"
        ];
      };

      lsp = {
        enable = true;
        servers.clangd.enable = true;
      };

      cmp = {
        enable = true;
        autoEnableSources = true;
        settings.sources = [
          { name = "nvim_lsp"; }
          { name = "buffer"; }
          { name = "path"; }
        ];
      };

      leetcode = {
        enable = true;
        settings = {
          lang = "python3";
          storage = {
            home = "~/projects/leetcode";
          };
        };
      };
    };
  };
}
