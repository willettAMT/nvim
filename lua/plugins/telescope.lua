local km = vim.keymap

local config = function()
    local telescope = require('telescope')
    telescope.setup({
        defaults = {
            mappings = {
                i = {
                    ["<C-j>"] = "move_selection_next",
                    ["<C-k>"] = "move_selection_previous",
                },
            },
        },
        pickers = {
            find_files = {
                theme = "dropdown",
                previewer = true,
                hidden = true,
            },
            live_grep = {
                theme = "dropdown",
                previewer = true,
            }
        },
        extensions = {
            undo = {
                use_delta = true,
                side_by_side = false,
                time_format = "",
                entry_format = "state #$ID, $STAT, $TIME",
                mappings = {
                    i = {
                        ["<cr>"] = require("telescope-undo.actions").yank_additions,
                        ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
                        ["<C-cr>"] = require("telescope-undo.actions").restore,
                        -- alternative defaults, for users whose terminals do questionable things with modified <cr>
                        ["<C-y>"] = require("telescope-undo.actions").yank_deletions,
                        ["<C-r>"] = require("telescope-undo.actions").restore,
                    },
                    n = {
                        ["y"] = require("telescope-undo.actions").yank_additions,
                        ["Y"] = require("telescope-undo.actions").yank_deletions,
                        ["u"] = require("telescope-undo.actions").restore,
                    },
                },
            },
        },
    })
end

return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    lazy = false,
    dependencies = { 'nvim-lua/plenary.nvim', 'debugloop/telescope-undo.nvim' },
    config = config,
    keys = {
        km.set('n', "<leader>pp", ":Telescope <CR>"),
        km.set('n', "<leader>pf", ":Telescope find_files<CR>"),
        km.set('n', "<leader>ps", ":Telescope live_grep<CR>"),
        km.set('n', "<leader>pb", ":Telescope buffers<CR>"),
        km.set('n', "<C-p>", ":Telescope git_files<CR>"),
    },
}
