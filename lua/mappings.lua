require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Also support ctrl-s save
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", "<leader>fg", "<cmd> Telescope live_grep <CR>", { desc = "Telescope Live Grep" })

map("n", "<leader>gb", function()
  require("gitsigns").blame_line()
end, { desc = "Git blame" })

-- diagnostics popup in modal rather than a split buffer
map("n", "<leader>le", function()
  vim.diagnostic.open_float { border = "rounded" }
end, { desc = "Diagnostic" })

-- Trims trailing whitespace on save
vim.cmd [[
   function! TrimWhiteSpace()
     %s/\s*$//
       ''
   endfunction
   autocmd FileWritePre * call TrimWhiteSpace()
   autocmd FileAppendPre * call TrimWhiteSpace()
   autocmd FilterWritePre * call TrimWhiteSpace()
   autocmd BufWritePre * call TrimWhiteSpace()
]]

