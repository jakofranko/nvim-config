require('oil').setup({
    view_options = {
        show_hidden = ture
    }
})

vim.keymap.set('n', '<leader>pv', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
