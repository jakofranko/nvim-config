local feline = require('feline')

feline.setup()
feline.winbar.setup()


vim.schedule(function()
    require('nvim-web-devicons').setup() 
end)
