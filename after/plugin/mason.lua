-- Non-Mason LSPs
-- nvim_lsp.dartls.setup({
--     cmd = { 'dart', "C:\\tools\\dart-sdk\\bin\\snapshots\\analysis_server.dart.snapshot", '--lsp' },
-- })

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
	}
})
