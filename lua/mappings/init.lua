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

-- Close NvimTree if it's the last window after :q
vim.api.nvim_create_autocmd("QuitPre", {
  callback = function()
    local invalid_win = {}
    local wins = vim.api.nvim_list_wins()
    for _, w in ipairs(wins) do
      local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
      if bufname:match "NvimTree_" ~= nil then
        table.insert(invalid_win, w)
      end
    end
    if #invalid_win == #wins - 1 then
      -- Should quit, so we close all invalid windows.
      for _, w in ipairs(invalid_win) do
        vim.api.nvim_win_close(w, true)
      end
    end
  end,
})

map("n", "<f9>", function()
  require("neotest").run.run()
end, { desc = "NeoTest Closest" })

map("n", "<s-f9>", function()
  require("neotest").run.run()
end, { desc = "NeoTest File" })

map("n", "B", function()
  require("dap").toggle_breakpoint()
end, { silent = true, desc = "Breakpoint" })

map("n", "<leader>DC", function()
  require("dapui").close()
end, { silent = true, desc = "Close Dap UI" })

require "mappings.rust"
