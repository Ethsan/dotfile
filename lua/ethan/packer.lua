-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
-- :
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use 'andweeb/presence.nvim'

    use 'stevearc/vim-arduino'

    use {
        'nvim-telescope/telescope.nvim',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use({
        'ellisonleao/gruvbox.nvim',
        config = function()
            vim.o.background = "dark"
            vim.cmd("colorscheme gruvbox")
        end
    })


    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use("nvim-treesitter/playground")
    use("mbbill/undotree")
    use("tpope/vim-fugitive")
    use("nvim-treesitter/nvim-treesitter-context");

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }

    use {
        'zbirenbaum/copilot.lua',
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                panel = { enabled = false },
                suggestion = { enabled = false }
            })
        end
    }
    use {
        "zbirenbaum/copilot-cmp",
        after = { "copilot.lua", "lsp-zero.nvim" },
        config = function()
            require("copilot_cmp").setup()
        end
    }

    use {
        "gptlang/CopilotChat.nvim",
        after = { "copilot.lua" },
    }

    use {
        'kkoomen/vim-doge',
        run = ':call doge#install()'
    }
    use {
        'mfussenegger/nvim-jdtls',
    }
    use {
        'edluffy/hologram.nvim'
    }
    use {
        'sindrets/diffview.nvim'
    }
    use { 'vigoux/ltex-ls.nvim', requires = 'neovim/nvim-lspconfig' }
end)
