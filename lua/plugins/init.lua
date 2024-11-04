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
        "rust",
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
  {
    "mfussenegger/nvim-dap",
    config = function()
      vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "🟧", texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define("DapLogPoint", { text = "🟩", texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "⬜", texthl = "", linehl = "", numhl = "" })
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    opts = { floating = { border = "rounded" } },
    config = function(...)
      require "configs.dap-ui"(...)
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    lazy = false,
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function(_, _)
      require("nvim-dap-virtual-text").setup()
    end,
  },
  {
    "nvim-neotest/neotest",
    config = function()
      require("neotest").setup {
        adapters = {
          require "rustaceanvim.neotest",
        },
      }
    end,
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "OXY2DEV/markview.nvim",
    -- lazy = false,      -- Recommended
    ft = "markdown", -- If you decide to lazy-load anyway
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
}
