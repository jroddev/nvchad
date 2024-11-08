local map = vim.keymap.set
local current_ft = vim.bo.filetype

-- Check if the current file is within a Rust project by looking for Cargo.toml
local function in_rust_project()
  local cargo_toml = vim.fn.findfile("Cargo.toml", ".;")
  return cargo_toml ~= ""
end

if in_rust_project() or current_ft == "rust" then
  map("n", "<c-F9>", function()
    vim.cmd.RustLsp "testables"
  end, { desc = "Rust: Testables" })

  map("n", "<F10>", function()
    vim.cmd.RustLsp { "runnables", bang = true }
  end, { desc = "Rust: Rerun last Runnable" })

  map("n", "<s-F10>", function()
    vim.cmd.RustLsp "runnables"
  end, { desc = "Rust: Runnables List" })

  map("n", "<F11>", function()
    require("dapui").open()
    vim.cmd.RustLsp { "debuggables", bang = true }
  end, { desc = "Rust: Rerun last Debuggable" })

  map("n", "<s-F11>", function()
    require("dapui").open()
    vim.cmd.RustLsp "debuggables"
  end, { desc = "Rust: Debuggables List" })

  map("n", "EM", function()
    vim.cmd.RustLsp "expandMacro"
  end, { desc = "Rust: Expand Macros" })

  map("n", "EE", function()
    vim.cmd.RustLsp{ "explainError", "cycle" }
  end, { desc = "Rust: Expand Macros" })

  map("n", "K", function()
    vim.cmd.RustLsp { "hover", "actions" }
  end, { silent = true, buffer = vim.api.nvim_get_current_buf() })

  map("n", "<leader>a", function()
    vim.cmd.RustLsp "codeAction" -- supports rust-analyzer's grouping
  end, { silent = true, buffer = vim.api.nvim_get_current_buf() })


end
