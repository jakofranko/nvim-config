local nvim_lsp = require('lspconfig')

-- Non-Mason LSPs
nvim_lsp.dartls.setup({
    cmd = { 'dart', "C:\\tools\\dart-sdk\\bin\\snapshots\\analysis_server.dart.snapshot", '--lsp' },
})

-- to learn how to use mason.nvim
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Mason can still be used to manage LSPs, but as of 0.11,
-- they now have to be enabled semi-manually.
-- In the future, may not need mason at all.
require('mason').setup({})
require('mason-lspconfig').setup({
    automatic_enable = false,
	ensure_installed = {
		"cssls",
		"emmet_ls",
		"eslint",
		"html",
		"htmx",
		"marksman",
        "gopls",
		"rubocop",
        "ts_ls",
        "denols"
	},
	handlers = {
		function(server_name)
			nvim_lsp[server_name].setup({
				capabilities = lsp_capabilities,
			})
		end,
		lua_ls = function()
			nvim_lsp.lua_ls.setup({
				capabilities = lsp_capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = {'vim'},
						},
						workspace = {
							library = {
								vim.env.VIMRUNTIME,
							}
						}
					}
				}
			})
		end,
        denols = function()
            nvim_lsp.denols.setup({
                capabilities = lsp_capabilities,
                on_attach = on_attach,
                root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc"),
            })
        end,
        ts_ls = function()
            nvim_lsp.ts_ls.setup({
                capabilities = lsp_capabilities,
                on_attach = on_attach,
                root_dir = nvim_lsp.util.root_pattern("tsconfig.json"),
                single_file_support = false
            })
        end
	}
})
local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'buffer', keyword_length = 3},
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
})
