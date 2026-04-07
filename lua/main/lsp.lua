vim.lsp.enable('gopls')
vim.lsp.config['gopls'] = {
    settings = {
        gopls = {
            gofumpt = true
        }
    }
}

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("GoFormat", { clear = true }),
  pattern = "*.go",
  callback = function()
    vim.lsp.buf.format { async = false }
  end,
})


vim.lsp.enable('rubocop')
vim.lsp.config['rubocop'] = {
    cmd = { "bundle", "exec", "rubocop", "--lsp" },
    filetypes = { "ruby", "rb" },
    root_markers = {
        'vessel.rb',
        'index.rb',
        'main.rb',
        'Gemfile',
        '.git',
    }
}

vim.lsp.enable('tsserver')
vim.lsp.config['tsserver'] = {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
}

vim.lsp.enable('lua_ls')
vim.lsp.config['lua_ls'] = {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
  -- Specific settings to send to the server. The schema is server-defined.
  -- Example: https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
      -- Get the language server to recognize the `vim` global
          globals = {'vim', 'require'},
      },
      workspace = {
        library = {
            vim.fn.expand("$VIMRUNTIME/lua"),
            vim.fn.expand("$XDG_CONFIG_HOME") .. "/nvim/lua",
        },
      },
    }
  },
}
