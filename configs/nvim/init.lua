require("config.init")
require("mason").setup()


vim.cmd 'colorscheme gruvbox'


local o = vim.o
o.relativenumber = true
o.number = true

o.expandtab = true
o.smartindent = true
o.tabstop = 4
o.shiftwidth = 4

o.incsearch = true
o.ignorecase = true

o.cursorline = true
o.cursorlineopt = "number"

o.wrap = false

vim.keymap.set('n', '<leader>e', ':Ex<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-\\>', ":ToggleTerm direction=float<CR>", { noremap = true, silent = true })

vim.keymap.set('n', '<leader>?', ':lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })


vim.g.netrw_bufsettings = 'noma nomod nu rnu nobl nowrap ro'
