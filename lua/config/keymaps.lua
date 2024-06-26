local keymap = vim.keymap
-- local opts = { noremap = true, silent = true }

-- Directory Navigation
keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move CMD ( highlight and move)
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '>-2<CR>gv=gv")

-- Keep cursor in middle of page while half-page jumping
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

-- Keep cursor in middle while searching terms
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- deletes highlighted word into void register w/o losing highlighted copy (using TMUX)
keymap.set("x", "<leader>p", "\"_dP")

-- switch projects BLAZINGLY FAST
keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tumux-sesssionizer<CR>")
keymap.set("n", "<leader>f", function()
  vim.lsp.buf.format()
end)

-- Indentation navigation
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- Quickfix navigation
keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Will create bash executable
keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Comments
vim.api.nvim_set_keymap("n", "<C-/>", "gcc", { noremap = false })
vim.api.nvim_set_keymap("v", "<C-/>", "gcc", { noremap = false })
