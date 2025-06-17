-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- Auto format on save

local opt = vim.opt

-- try this: vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

opt.ignorecase = true

-- scrolling
opt.number = true
opt.relativenumber = true
opt.scrolloff = 8

-- wrap / break

 opt.textwidth = 80
 opt.linebreak = true

-- indentation
opt.list = true
opt.listchars = { tab = '▸ ', trail = '·', nbsp = '·' }
opt.expandtab = false -- convert tabs to spaces
opt.tabstop = 4 -- insert 4 spaces for a tab
opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
opt.smartindent = true

-- windows
-- vim.o.splitbelow = true
-- vim.o.splitright = true

-- completion
-- vim.o.timeoutlen = 300 -- time to wait for a mapped sequence to complete
--
-- g.vim_markdown_conceal = 0
--
--
-- opt.vim_markdown_conceal = 0
--
-- vim.g.mkdp_browser = "/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge"

vim.g.lazygit_config = false

vim.g.snacks_animate = false
