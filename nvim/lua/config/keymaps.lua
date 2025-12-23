-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- require("nvchad.mappings")

-- add yours here
--
--

local map = vim.keymap.set

map("n", "j", "gjzz")
map("n", "k", "gkzz")
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "kj", "<ESC>")

--------------------------------------
-- WARNING: doesn't work :(
map("n", "<leader>xa", function()
  require("bufferline").closeAllBufs()
end, { desc = "Close all buffers" })
--------------------------------------

-- save and quit
map({ "n", "v" }, "<leader>q", ":q<CR>")
map({ "n", "v" }, "<leader>qa", ":qa<CR>")
map({ "n", "v" }, "<leader>wq", ":wq<CR>")
map({ "n", "v" }, "<leader>w", ":w<CR>")
map({ "n", "v" }, "<leader>W", ":w!<CR>")
map({ "n", "v" }, "<leader>Q", ":q!<CR>")

-- open a terminalwindow vertically and use the command "ollama run llam3" and insert
map("n", "<leader>ll", ":terminal ollama run llama3<CR>i")
map("n", "<leader>llh", ":split | terminal ollama run llama3<CR>i")
map("n", "<leader>llv", ":vsplit | terminal ollama run llama3<CR>i")

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- toggle terminal
--
-- map({ "n" }, "<leader>v", function()
--   require("term").toggle({ pos = "vsp", id = "verticalTerm" })
-- end, { desc = "Terminal Toggle vertical term" })
-- map({ "t" }, "<leader><leader>v", function()
--   require("term").toggle({ pos = "vsp", id = "verticalTerm" })
-- end, { desc = "Terminal Toggle vertical term" })
-- map({ "n" }, "<leader>h", function()
--   require("term").toggle({ pos = "sp", id = "horizontalTerm" })
-- end, { desc = "Terminal Toggle horizontal term" })
-- map({ "t" }, "<leader><leader>h", function()
--   require("term").toggle({ pos = "sp", id = "horizontalTerm" })
-- end, { desc = "Terminal Toggle horizontal term" })

-- toggle ntree
map({ "n", "v" }, "<leader>n", ":NvimTreeToggle<CR>")

--
-- local map = vim.keymap.set
--
-- map("n", ";", ":", { desc = "CMD enter command mode" })
--
-- map("i", "jk", "<ESC>")
-- map("i", "kj", "<ESC>")
--
-- map("n","<leader>qq", ":q!<CR>", {noremap = true})
--                                     --map("i","<leader>xx", ":<C-X>", {noremap = true})
-- --map("c","<leader>xx", ":<C-X>", {noremap = true})
-- -- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
-- --
-- --
-- -- "" Vmap for maintain Visual Mode after shifting > and <
-- -- vmap < <gv
-- -- vmap > >gv
-- map("v", "<", "<gv")
-- map("v", ">", ">gv")
-- --
-- -- not possible yet cuz it split with terminal right now
-- -- "" Split
-- -- noremap <Leader>h :<C-u>split<CR>
-- -- noremap <Leader>v :<C-u>vsplit<CR>
-- --
-- --
--
-- --vnoremap J :m '>+1<CR>gv=gv
-- map("v", "J", ":m '>+1<CR>gv=gv", {noremap = true})
-- --vnoremap K :m '<-2<CR>gv=gv
-- map("v", "K", ":m '<-2<CR>gv=gv", {noremap = true})
--
-- -- " Better nav for omnicomplete
--   inoremap <expr> <c-j> ("\<C-n>")
--   inoremap <expr> <c-k> ("\<C-p>")
map("i", "<A-k>", "<C-p>", { noremap = true }) -- remap better in visual??
map("i", "<A-j>", "<C-n>", { noremap = true })
-- fuuck the termnal is still opening like with leader h

-- Disable joining lines in visual mode when pressing J
map("v", "J", "<Nop>")
