-- All LSP configs are in the lsp/ folder

-- Go
vim.lsp.enable('gopls')
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("GoFormat", { clear = true }),
  pattern = "*.go",
  callback = function()
    vim.lsp.buf.format { async = false }
  end,
})

-- Ruby
vim.lsp.enable('rubocop')
vim.lsp.enable('ruby-lsp')

-- JavaScript / TypeScript
vim.lsp.enable('tsserver')

-- Lua
vim.lsp.enable('lua_ls')
