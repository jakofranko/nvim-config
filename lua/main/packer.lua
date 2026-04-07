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
        -- or                          , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- Themes
    use({ 'bluz71/vim-nightfly-colors', as = 'nightfly' })
    use({
        'sainnhe/gruvbox-material',
        config = function()
            vim.g.gruvbox_material_enable_italic = true
            vim.cmd.colorscheme('gruvbox-material')
        end
    })
    use({
        'folke/tokyonight.nvim',
        as = 'tokyonight',
        -- config = function()
        --     vim.cmd('colorscheme tokyonight')
        -- end
    })

    -- Rendering / UI
    use('lewis6991/gitsigns.nvim')
    use('nvim-tree/nvim-web-devicons')
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons' }
    }
    use {
        'AndreM222/copilot-lualine',
        requires = { 'nvim-lualine/lualine.nvim', 'zbirenbaum/copilot.lua' }
    }
    use('MunifTanjim/nui.nvim') -- NeoVim UI Component librar
    use('folke/which-key.nvim') -- Keybinding hints
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate'})
    use('nvim-treesitter/playground')
    use({
        'MeanderingProgrammer/render-markdown.nvim',
        after = { 'nvim-treesitter' },
        requires = { 'nvim-tree/nvim-web-devicons', opt = true },
        -- There are options for mini.nvim and mini.icons...for future reference
        config = function()
            require('render-markdown').setup({})
        end
    })

    -- cmp auto-completion
    use('hrsh7th/nvim-cmp')
    use('hrsh7th/vim-vsnip')
    use('hrsh7th/cmp-vsnip')
    use('hrsh7th/cmp-path')
    use('hrsh7th/cmp-buffer')
    use('hrsh7th/cmp-nvim-lsp')
	use {
	  "zbirenbaum/copilot-cmp",
	  after = { "copilot.lua" },
	  config = function ()
		require("copilot_cmp").setup()
	  end
	}


    -- LSP -> Deprecate in favor of nvim 0.11 native LSPs
    use('neovim/nvim-lspconfig')
    use('williamboman/mason.nvim')
    use('williamboman/mason-lspconfig.nvim')

    -- Utils
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
    use('mbbill/undotree')          -- Undo history UI
    use('tpope/vim-fugitive')       -- :Git stuff
    use('tpope/vim-surround')
    use('mattn/emmet-vim')          -- HTML musthave
    use('bullets-vim/bullets.vim')  -- Auto bullet list creation
    use('stevearc/oil.nvim')        -- File system viewer

    -- Debugging / DAP plugins
    use('mfussenegger/nvim-dap')
    use({
        'leoluz/nvim-dap-go',
        config = function()
            require('dap-go').setup()
        end,
        requires = { 'mfussenegger/nvim-dap' }
    })

    -- Go
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

	-- Lua
	use({ -- Format Lua
        "ckipp01/stylua-nvim",
        run = "cargo install stylua"
    })

    -- AI garbage
    use {
        'zbirenbaum/copilot.lua',
        config = function()
            require('copilot').setup({
                suggestion = { enabled = false }, -- Disabled to work with copilot-cmp
                panel = { enabled = false }
            })
        end
    }

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
	  require('packer').sync()
	end
end)
