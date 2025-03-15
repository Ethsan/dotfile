-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

opt.colorcolumn = "80"

opt.shiftwidth = 8
opt.tabstop = 8
opt.softtabstop = 8
opt.expandtab = false

opt.confirm = false

opt.conceallevel = 1

opt.timeoutlen = 1000

opt.autowrite = false

opt.cursorline = false

vim.g.spell = false

vim.g.autoformat = false

-- see https://github.com/tree-sitter-grammars/tree-sitter-hyprlang
vim.filetype.add({
  pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})

vim.g.snacks_animate = false
