{ pkgs, config, ... }:

{
  opts = {
    clipboard = "unnamedplus";
    number = true;
    relativenumber = true;
    swapfile = false;
    tabstop = 2;
    shiftwidth = 2;
    expandtab = true;
  };

  globals.mapleader = " ";

  keymaps = [
    { mode = "n"; key = "-"; action = "<cmd>Oil<cr>"; options.desc = "Open parent dir (oil)"; }
    { mode = "n"; key = "<leader>n"; action = "<cmd>nohlsearch<CR>"; options.desc = "Clear search highlight"; }
    { mode = "n"; key = "<leader>d"; action.__raw = ''function() vim.diagnostic.open_float() end''; options.desc = "Show LSP diagnostic (float)"; }
    { mode = "n"; key = "<leader>D"; action.__raw = ''function() vim.diagnostic.jump({ count = 1 }) end''; options.desc = "Next LSP diagnostic"; }
    { mode = "n"; key = "<leader>ff"; action = "<cmd>Telescope find_files<cr>"; options.desc = "Find files with telescope"; }
    { mode = "n"; key = "<leader>fg"; action = "<cmd>Telescope live_grep<cr>"; options.desc = "Live grep"; }
    { mode = "n"; key = "<leader>fb"; action = "<cmd>Telescope buffers<cr>"; options.desc = "Find buffers"; }
    { mode = "n"; key = "<leader>c"; action = "<cmd>CompletionToggle<cr>"; options.desc = "Toggle completion"; }
  ];

  plugins.lsp.keymaps.extra = [
    { mode = "n"; key = "<leader>lr"; action.__raw = ''function() vim.lsp.buf.rename() end''; options.desc = "LSP rename symbol"; }
    { mode = [ "n" "v" ]; key = "<leader>la"; action.__raw = ''function() vim.lsp.buf.code_action() end''; options.desc = "LSP code action"; }
    { mode = "n"; key = "<leader>lR"; action.__raw = ''function() vim.lsp.buf.references() end''; options.desc = "LSP references"; }
    { mode = "n"; key = "<leader>lf"; action.__raw = ''function() vim.lsp.buf.format({ async = true }) end''; options.desc = "LSP format buffer"; }
    { mode = "n"; key = "<leader>le"; action.__raw = ''function() vim.diagnostic.open_float() end''; options.desc = "LSP line diagnostics (float)"; }
    { mode = "n"; key = "<leader>ld"; action.__raw = ''function() vim.lsp.buf.definition() end''; options.desc = "LSP go to definition"; }
  ];

  userCommands = {
    CompletionToggle = {
      command.__raw = ''
        function()
          vim.b.completion = vim.b.completion == false
          vim.notify("Completion " .. (vim.b.completion and "on" or "off"))
        end
      '';
      desc = "Toggle completion in current buffer";
    };
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
      rust-analyzer
    ];

  plugins.treesitter = {
    enable = true;
    highlight.enable = true;
    indent.enable = true;
    # allGrammars = builtGrammars ++ prebuiltGrammars; the previous
    # builtGrammars subset was already contained in it.
    grammarPackages = config.plugins.treesitter.package.allGrammars;
  };

  plugins.sleuth = {
    enable = true;
  };

  plugins.web-devicons = {
    enable = true;
  };

  plugins.oil = {
    enable = true;
    settings = {
      skip_confirm_for_simple_edits = true;
      keymaps."q" = "actions.close";
    };
  };

  plugins.telescope = {
    enable = true;
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
      rust_analyzer = {
      enable = true;
      installCargo = true;
      installRustc = true;
    };
    };
  };
}
