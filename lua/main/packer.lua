local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.6',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- Syntax Highlighting
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate'})
    use('nvim-treesitter/playground')

    -- LSP utils
    use('neovim/nvim-lspconfig')
    use('hrsh7th/nvim-cmp')
    use('hrsh7th/cmp-nvim-lsp')
    use('L3MON4D3/LuaSnip')
    use('williamboman/mason.nvim')
    use('williamboman/mason-lspconfig.nvim')

    use {
        "theprimeagen/harpoon",
        branch = "harpoon2",
        requires = { {"nvim-lua/plenary.nvim"} },
        config = function ()
            local harpoon = require("harpoon")

            -- REQUIRED
            harpoon:setup()
            -- REQUIRED
            
            vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
            vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

            vim.keymap.set("n", "<C-1>", function() harpoon:list():select(1) end)
            vim.keymap.set("n", "<C-2>", function() harpoon:list():select(2) end)
            vim.keymap.set("n", "<C-3>", function() harpoon:list():select(3) end)
            vim.keymap.set("n", "<C-4>", function() harpoon:list():select(4) end)

            -- Toggle previous & next buffers stored within Harpoon list
            vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
            vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
        end
    }


    use('mbbill/undotree')
    use('tpope/vim-fugitive')
    use('tpope/vim-surround')
    use({ 
        'folke/tokyonight.nvim', 
        as = 'tokyonight',
        config = function()
            vim.cmd('colorscheme tokyonight')
        end
    })
    use('mattn/emmet-vim')
    use('famiu/feline.nvim')
    use('nvim-tree/nvim-web-devicons')
    use('lewis6991/gitsigns.nvim')
    use {
        'olexsmir/gopher.nvim',
        ft = 'go',
        requires = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-treesitter/nvim-treesitter' },
        },
        ---@type gopher.Config
        opts = {},
        build = function()
            vim.cmd.GoInstallDeps()
        end,
        config = function()
            local g = require('gopher')
            g.setup()
            vim.keymap.set("n", "<leader>gtj", function() g.tags.add "json" end)
            vim.keymap.set("n", "<leader>gty", function() g.tags.add "yaml" end)
            vim.keymap.set("n", "<leader>gie", function() vim.cmd('GoIfErr') end)
            vim.keymap.set("n", "<leader>gii", function() vim.cmd('GoImpl') end)
        end
    }
    use {
        "lukas-reineke/headlines.nvim",
        after = "nvim-treesitter"
    }
    use('bullets-vim/bullets.vim')
    use('stevearc/oil.nvim')

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
	  require('packer').sync()
	end
end)
