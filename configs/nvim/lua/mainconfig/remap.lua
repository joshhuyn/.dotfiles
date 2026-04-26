vim.g.mapleader = " "
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>pv", "<cmd>Ex<CR>")

vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>");

vim.keymap.set("n", "<leader>zz", "<cmd>ZenMode<CR>");

vim.keymap.set("n", "<C-\\>", "<cmd>ToggleTerm<CR>");

vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>pf", builtin.find_files, {});
vim.keymap.set("n", "<leader>ps", builtin.live_grep, {});
vim.keymap.set("n", "<leader>pb", builtin.buffers, {});
