-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map("n", "<leader>qw", "<cmd>wqa<CR>", { desc = "Save and Quit All" })

map("n", "<leader>t", "<cmd>!alacritty &<CR>", { desc = "Open Detached Terminal" })

map("i", "<A-q>", "<Esc>", { desc = "Exit insert mode" })
