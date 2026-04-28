require("config.init")
require("mason").setup()

vim.cmd 'colorscheme catppuccin-nvim'


local o = vim.o
o.relativenumber = true
o.number = true

o.tabstop = 4
o.shiftwidth = 4
o.wrap = false

vim.keymap.set('n', '<leader>e', ':Ex<CR>', { noremap = true, silent = true })
