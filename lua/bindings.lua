local opts = {noremap = true, silent = true }

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end)

vim.keymap.set('n', '<Leader>c', ':set cursorline! relativenumber!<CR>', opts)

vim.keymap.set('t', '<A-ESC>', '<C-\\><C-n>', opts)
vim.keymap.set('t', '<C-ESC>', '<C-\\><C-n>', opts)
vim.keymap.set('t', '<C-w>', '<C-\\><C-n><C-w>', opts);
vim.keymap.set('i', 'jj', '<ESC>', opts)
