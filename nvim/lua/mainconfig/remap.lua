vim.g.mapleader = " "
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>pv", "<cmd>Ex<CR>")

vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>");

vim.keymap.set("n", "<leader>zz", "<cmd>ZenMode<CR>");

vim.keymap.set("n", "<C-\\>", "<cmd>ToggleTerm<CR>");

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>pf", builtin.find_files, {});
vim.keymap.set("n", "<leader>pb", builtin.buffers, {});
