return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        plugins = {
            marks = true, -- shows a list of your marks on ' and `
            registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
            spelling = {
                enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
                suggestions = 20, -- how many suggestions should be shown in the list?
            },
            -- the presets plugin, adds help for a bunch of default keybindings in Neovim
            -- No actual key bindings are created
            presets = {
                operators = true, -- adds help for operators like d, y, ...
                motions = true, -- adds help for motions
                text_objects = true, -- help for text objects triggered after entering an operator
                windows = true, -- default bindings on <c-w>
                nav = true, -- misc bindings to work with windows
                z = true, -- bindings for folds, spelling and others prefixed with z
                g = true, -- bindings for prefixed with g
            },
        },
        -- add operators that will trigger motion and text object completion
        -- to enable all native operators, set the preset / operators plugin above
        operators = { gc = "Comments" },
        key_labels = {
            -- override the label used to display some keys. It doesn't effect WK in any other way.
            ["<space>"] = "SPC",
            ["<cr>"] = "RET",
            ["<tab>"] = "TAB",
        },
        motions = {
            count = true,
        },
        icons = {
            breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
            separator = "➜", -- symbol used between a key and it's label
            group = "+", -- symbol prepended to a group
        },
        popup_mappings = {
            scroll_down = "<c-d>", -- binding to scroll down inside the popup
            scroll_up = "<c-u>", -- binding to scroll up inside the popup
        },
        window = {
            border = "rounded", -- none, single, double, shadow
            position = "bottom", -- bottom, top
            margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
            padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
            winblend = 0, -- value between 0-100 0 for fully opaque and 100 for fully transparent
        },
        layout = {
            height = { min = 4, max = 25 }, -- min and max height of the columns
            width = { min = 20, max = 50 }, -- min and max width of the columns
            spacing = 3, -- spacing between columns
            align = "left", -- align columns left, center or right
        },
        ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
        hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "^:", "^ ", "^call ", "^lua " }, -- hide mapping boilerplate
        show_help = true, -- show a help message in the command line for using WhichKey
        show_keys = true, -- show the currently pressed key and its label as a message in the command line
        triggers = "auto", -- automatically setup triggers
        -- triggers = {"<leader>"} -- or specify a list manually
        -- list of triggers, where WhichKey should not wait for timeoutlen and show immediately
        triggers_nowait = {
            -- marks
            "`",
            "'",
            "g`",
            "g'",
            -- registers
            '"',
            "<c-r>",
            -- spelling
            "z=",
        },
        triggers_blacklist = {
            -- list of mode / prefixes that should never be hooked by WhichKey
            -- this is mostly relevant for keymaps that start with a native binding
            i = { "j", "k" },
            v = { "j", "k" },
        },
        -- disable the WhichKey popup for certain buf types and file types.
        -- Disabled by default for Telescope
        disable = {
            buftypes = {},
            filetypes = {},
        },
    },
    config = function(_, opts)
        local wk = require("which-key")
        wk.setup(opts)
        
        -- Register key groups and descriptions for better organization
        wk.register({
            -- Project/Files
            ["<leader>p"] = { name = "+project/find" },
            ["<leader>pf"] = { "Find files" },
            ["<leader>ps"] = { "Live grep" },
            ["<leader>pb"] = { "Find buffers" },
            ["<leader>pp"] = { "Telescope" },
            ["<leader>pv"] = { "File explorer (netrw)" },
            
            -- LSP
            ["<leader>g"] = { name = "+goto" },
            ["<leader>gd"] = { "Go to definition (same buffer)" },
            ["<leader>gD"] = { "Go to declaration (same buffer)" },
            ["<leader>gi"] = { "Go to implementation (new tab)" },
            ["<leader>gt"] = { "Go to type definition (new tab)" },
            ["<leader>gr"] = { "Find references" },
            
            ["<leader>l"] = { name = "+lsp" },
            ["<leader>lr"] = { "References (telescope)" },
            ["<leader>ls"] = { "Document symbols" },
            ["<leader>lS"] = { "Workspace symbols" },
            ["<leader>ld"] = { "Diagnostics" },
            
            ["<leader>r"] = { name = "+refactor" },
            ["<leader>rn"] = { "Rename symbol" },
            
            ["<leader>c"] = { name = "+code" },
            ["<leader>ca"] = { "Code actions" },
            ["<leader>cc"] = { "Copy line to clipboard" },
            
            ["<leader>d"] = { name = "+diagnostics/debug" },
            ["<leader>de"] = { "Show diagnostic popup" },
            ["<leader>db"] = { "Debug: Toggle breakpoint" },
            ["<leader>dl"] = { "Debug: Step into" },
            ["<leader>dj"] = { "Debug: Step over" },
            ["<leader>dk"] = { "Debug: Step out" },
            ["<leader>dc"] = { "Debug: Continue" },
            ["<leader>dd"] = { "Debug: Conditional breakpoint" },
            ["<leader>dx"] = { "Debug: Terminate" },
            ["<leader>dr"] = { "Debug: Run last" },
            ["<leader>dt"] = { "Debug: Run testables" },
            
            -- Harpoon
            ["<leader>a"] = { "Harpoon: Add file" },
            ["<leader>e"] = { "Harpoon: Toggle menu" },
            ["<leader>1"] = { "Harpoon: Select 1" },
            ["<leader>2"] = { "Harpoon: Select 2" },
            ["<leader>3"] = { "Harpoon: Select 3" },
            ["<leader>4"] = { "Harpoon: Select 4" },
            
            -- Workspace
            ["<leader>w"] = { name = "+workspace" },
            ["<leader>wa"] = { "Add workspace folder" },
            ["<leader>wr"] = { "Remove workspace folder" },
            ["<leader>wl"] = { "List workspace folders" },
            
            -- Quickfix/Location
            ["<leader>q"] = { "Open diagnostics in location list" },
            ["<leader>k"] = { "Next location list" },
            ["<leader>j"] = { "Previous location list" },
            
            -- Utilities
            ["<leader>u"] = { "Toggle undotree" },
            ["<leader>x"] = { "Make file executable" },
            ["<leader>f"] = { "Format buffer" },
            ["<leader>sh"] = { "Signature help" },
        })
        
        -- Register some additional helpful groups
        wk.register({
            -- Motions and objects that are useful to remember
            ["g"] = { name = "+goto" },
            ["z"] = { name = "+folds/spelling" },
            ["]"] = { name = "+next" },
            ["["] = { name = "+prev" },
            
            -- Telescope (Ctrl+P)
            ["<C-p>"] = { "Git files" },
            
            -- Quickfix navigation
            ["<C-k>"] = { "Next quickfix item" },
            ["<C-j>"] = { "Previous quickfix item" },
            
            -- Other important keys
            ["<F2>"] = { "Rename symbol" },
            ["K"] = { "Hover documentation" },
            ["gd"] = { "Go to definition (new tab)" },
            ["gD"] = { "Go to declaration" },
            
            -- Diagnostics
            ["]d"] = { "Next diagnostic" },
            ["[d"] = { "Previous diagnostic" },
        })
        
        -- Register visual mode mappings
        wk.register({
            ["<leader>c"] = { name = "+code" },
            ["<leader>ca"] = { "Code actions" },
            ["<leader>c"] = { "Copy to clipboard" },
            ["J"] = { "Move line down" },
            ["K"] = { "Move line up" },
            ["<"] = { "Indent left" },
            [">"] = { "Indent right" },
        }, { mode = "v" })
    end,
}
