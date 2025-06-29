vim.lsp.enable('gopls')
vim.lsp.config['gopls'] = {
    settings = {
        gopls = {
            gofumpt = true
        }
    }
}

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
