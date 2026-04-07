return {
  filetypes = { "ruby" },
  cmd = { "ruby-lsp" },
  root_markers = {
	'vessel.rb',
	'index.rb',
	'main.rb',
	'Gemfile',
	'.git'
  },
  init_options = {
    formatter = 'standard',
    linters = { 'standard' },
    addonSettings = {
      ["Ruby LSP Rails"] = {
        enablePendingMigrationsPrompt = false,
      },
    },
  },
}
