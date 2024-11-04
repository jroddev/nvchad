local on_attach = require("nvchad.configs.lspconfig").on_attach

return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "bash",
        "python",
        "dockerfile",
        "yaml",
        "javascript",
        "typescript",
        "tsx",
        "json",
  		},
  	},
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    ft = { "rust" },
    lazy = false, -- This plugin is already lazy
    config = function(_, _)
      vim.g.rustaceanvim = {
        server = { on_attach = on_attach },
      }
    end,
  },
}
