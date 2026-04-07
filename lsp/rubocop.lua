
return {
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
