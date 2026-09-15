{ pkgs, ... }:

{
  opts = {
    clipboard = "unnamedplus";
  };

  extraPackages = with pkgs; [
    wl-clipboard
    pyright
    typescript-language-server
    nil
    clang-tools
    jdt-language-server
  ];

  plugins.treesitter = {
    enable = true;
    settings.ensure_installed = [ "python" "typescript" "nix" "c" "cpp" "java" ];
  };

  plugins.blink-cmp = {
    enable = true;
    settings = {
      keymap = {
        preset = "none";
        "<Tab>" = [ "select_next" "fallback" ];
        "<S-Tab>" = [ "select_prev" "fallback" ];
        "<CR>" = [ "accept" "fallback" ];
      };
      sources = {
        default = [ "lsp" "path" "buffer" ];
      };
    };
  };

  plugins.lsp = {
    enable = true;
    servers = {
      pyright.enable = true;
      ts_ls.enable = true;
      nil_ls.enable = true;
      clangd.enable = true;
      jdtls.enable = true;
    };
  };
}
