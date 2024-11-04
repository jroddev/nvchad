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

-- Rust
map("n", "<F9>", function()
  local current_ft = vim.bo.filetype
  if current_ft == "rust" then
    vim.cmd.RustLsp "testables"
  end
end, { desc = "Testables" })

map("n", "<F10>", function()
  local current_ft = vim.bo.filetype
  if current_ft == "rust" then
    vim.cmd.RustLsp "runnables"
  end
end, { desc = "Runnables" })

map("n", "<s-F10>", function()
  local current_ft = vim.bo.filetype
  if current_ft == "rust" then
    vim.cmd.RustLsp { "runnables", bang = true }
  end
end, { desc = "Rerun last Runnable" })

map("n", "<f11>", function()
  local current_ft = vim.bo.filetype
  if current_ft == "rust" then
    require("dapui").open()
    vim.cmd.RustLsp "debuggables"
  else
    require("dap").continue()
  end
end, { desc = "debuggables" })

map("n", "<s-f11>", function()
  local current_ft = vim.bo.filetype
  if current_ft == "rust" then
    require("dapui").open()
    vim.cmd.RustLsp { "debuggables", bang = true }
  else
    require("dap").continue()
  end
end, { desc = "debuggables" })

map("n", "B", function()
  require("dap").toggle_breakpoint()
end, { silent = true, desc = "Breakpoint" })

map("n", "<leader>DC", function()
  require("dapui").close()
end, { silent = true, desc = "Close Dap UI" })

map("n", "K", function()
  local current_ft = vim.bo.filetype
  if current_ft == "rust" then
    vim.cmd.RustLsp { "hover", "actions" }
  end
end, { silent = true, buffer = vim.api.nvim_get_current_buf() })

map("n", "<leader>a", function()
  local current_ft = vim.bo.filetype
  if current_ft == "rust" then
    vim.cmd.RustLsp "codeAction" -- supports rust-analyzer's grouping
  else
    vim.lsp.buf.codeAction() -- if you don't want grouping.
  end
end, { silent = true, buffer = vim.api.nvim_get_current_buf() })
