vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }

    use ('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        requires = { {'nvim-lua/plenary.nvim'} }
    }


    use {
        "jesseleite/nvim-noirbuddy",
        requires = { "tjdevries/colorbuddy.nvim", branch = "dev" },
        config = function()
            require("noirbuddy").setup({
                preset = 'miami-nights',
                colors = {
                    background = "#090909"
                }
            })
        end
    }

    use { "catppuccin/nvim", as = "catppuccin", config = function()
        require("catppuccin").setup({
            flavour = "mocha",
            transparent_background = true,
        })
    end}

    use { 'mbbill/undotree' }
    use { 'tpope/vim-fugitive' }
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},         -- Required
            {'hrsh7th/cmp-nvim-lsp'},     -- Required
            {'hrsh7th/cmp-buffer'},       -- Optional
            {'hrsh7th/cmp-path'},         -- Optional
            {'saadparwaiz1/cmp_luasnip'}, -- Optional
            {'hrsh7th/cmp-nvim-lua'},     -- Optional

            -- Snippets
            {'L3MON4D3/LuaSnip'},             -- Required
            {'rafamadriz/friendly-snippets'}, -- Optional
 
            {'hrsh7th/cmp-nvim-lsp-signature-help'}
        }
    }
end)
