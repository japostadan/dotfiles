-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
-- disable completion on markdown header and c files by default
-- Autoformat setting
local set_autoformat = function(pattern, bool_val)
  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = pattern,
    callback = function()
      vim.b.autoformat = bool_val
    end,
  })
end

set_autoformat({ "md" }, true)
set_autoformat({ "c" }, false)
set_autoformat({ "h" }, false)
set_autoformat({ "cpp" }, false)
set_autoformat({ "lua" }, true)
set_autoformat({ "yaml" }, true)
