{ pkgs, config, ... }:

{
  opts = {
    clipboard = "unnamedplus";
    number = true;
    relativenumber = true;
    swapfile = false;
  };

  highlightOverride = {
    Normal      = { bg = "none"; ctermbg = "none"; };
    NormalFloat = { bg = "none"; ctermbg = "none"; };
    NormalNC    = { bg = "none"; ctermbg = "none"; };
    SignColumn  = { bg = "none"; ctermbg = "none"; };
    LineNr      = { bg = "none"; ctermbg = "none"; };
    NonText     = { bg = "none"; ctermbg = "none"; };
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
    highlight.enable = true;
    indent.enable = true;
    settings = {
      highlight.enable = true;
      indent.enable = true;
    };
    grammarPackages = with config.plugins.treesitter.package.builtGrammars; [
      python
      typescript
      javascript
      nix
      c
      cpp
      java
    ];
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
