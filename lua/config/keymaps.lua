local keymap = vim.keymap.set
-- local opts = { noremap = true, silent = true }

-- Directory Navigation
keymap("n", "<leader>pv", vim.cmd.Ex)

-- Keep cursor in middle of page while half-page jumping
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

-- Keep cursor in middle of page when searching
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- Keeps copy buffer intact after pasting over value
keymap('x', "<leader>p", "\"_dp")

-- Visual mode moving highlighted code
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '>-2<CR>gv=gv")

-- Keep cursor in middle while searching terms
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- switch projects BLAZINGLY FAST
keymap("n", "<C-f>", "<cmd>silent !tmux new tumux-sessionizer<CR>")
keymap("n", "<leader>f", function()
    vim.lsp.buf.format()
end)

-- Indentation navigation
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- tmux-nvim-navigator
keymap('n', '<C-k>', ':wincmd k<CR>')
keymap('n', '<C-j>', ':wincmd j<CR>')
keymap('n', '<C-h>', ':wincmd h<CR>')
keymap('n', '<C-l>', ':wincmd l<CR>')
-- Quickfix navigation
-- keymap("n", "<C-k>", "<cmd>cnext<CR>zz")
-- keymap("n", "<C-j>", "<cmd>cprev<CR>zz")
-- keymap("n", "<leader>k", "<cmd>lnext<CR>zz")
-- keymap("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Will create bash executable
keymap("n", "<leader>mx", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })

-- Dap
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { desc = "Debug Toggle Breakpoint" })
keymap("n", "<leader>dl", "<cmd>lua require'dap'.step_into()<CR>", { desc = "Debug Step Into" })
keymap("n", "<leader>dj", "<cmd>lua require'dap'.step_over()<CR>", { desc = "Debug Step Over" })
keymap("n", "<leader>dk", "<cmd>lua require'dap'.step_out()<CR>", { desc = "Debug Step Out" })
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<CR>", { desc = "Debug Continue" })
keymap("n", "<leader>dd", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: ' ))<CR>",
    { desc = "Debug Set Conditional Breakpoint" })
keymap("n", "<leader>de", "<cmd>lua require'dap'.terminate()<CR>", { desc = "Debug Reset" })
keymap("n", "<leader>dr", "<cmd>lua require'dap'.run_last()<CR>", { desc = "Debug Run Last" })
keymap("n", "<leader>dt", "<cmd>lua vim.cmd('RustLsp testables;)<CR>", { desc = "Dubgger Run Testables" })

-- Comments
vim.api.nvim_set_keymap("n", "<C-/>", "gcc", { noremap = false })
vim.api.nvim_set_keymap("v", "<C-/>", "gcc", { noremap = false })
