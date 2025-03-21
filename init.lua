-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.p4 = {
	install_info = {
		url = "https://github.com/oxidecomputer/tree-sitter-p4", -- local path or git repo
		files = {"src/parser.c"}, -- note that some parsers also require src/scanner.c or src/scanner.cc
		-- optional entries:
		branch = "main", -- default branch in case of git repo if different from master
		generate_requires_npm = false, -- if stand-alone parser without npm dependencies
		requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
	},
	filetype = "p4", -- if filetype does not match the parser name
}
local configs = require('lspconfig.configs')
local lspconfig = require('lspconfig')

if not configs.althread then
	configs.althread = {
		default_config = {
			cmd = { '/home/ethan/althread/target/debug/language-server' },
			root_dir = lspconfig.util.root_pattern('.git', 'go.mod'),
			filetypes = { 'althread' },
			init_options = {
			},
		},
	}
end
lspconfig.althread.setup{}
-- no spell check
vim.opt.spell = false
