local nvim_lsp = require('lspconfig')
local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
	local opts = { buffer = bufnr, remap = false }
	vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end, opts)
	vim.keymap.set("n", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

-- to learn how to use mason.nvim
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = {
		"cssls",
		"emmet_ls",
		"eslint",
		"html",
		"htmx",
		"marksman",
		"rubocop",
        "gopls",
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
		gopls = function()
			nvim_lsp.gopls.setup({
				capabilities = lsp_capabilities,
				settings = {
                    gopls = {
                        gofumpt = true,
                        completeUnimported = true,
                        usePlaceholders = true,
                        analyses = {
                            unusedparams = true,
                        },
                    },
				},
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
