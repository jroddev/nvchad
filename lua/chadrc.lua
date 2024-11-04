-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "rxyhn",

  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}

-- ---@class MasonConfig
M.mason = {
  pkgs = {
    "stylua",
    "html-lsp",
    "css-lsp",
    "prettier",
    "ansible-language-server",
    "bash-language-server",
    "dockerfile-language-server",
    "lua-language-server",
    "yaml-language-server",
    "shellcheck",
    "shfmt",
    "rust-analyzer",
    "codelldb"
  },
}

return M
