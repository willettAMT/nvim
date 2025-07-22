
return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = "classic", -- "classic" | "modern" | "helix"
        -- Delay before showing the popup
        delay = function(ctx)
            return ctx.plugin and 0 or 200
        end,
        -- Filter mappings (you can customize this)
        filter = function(mapping)
            return true -- show all mappings
        end,
        -- Spec for your key mappings (replaces the old register method)
        spec = {
            -- Project/Files group
            { "<leader>p", group = "project/find" },
            { "<leader>pf", desc = "Find files" },
            { "<leader>ps", desc = "Live grep" },
            { "<leader>pb", desc = "Find buffers" },
            { "<leader>pp", desc = "Telescope" },
            { "<leader>pv", desc = "File explorer (netrw)" },
            -- LSP group
            { "<leader>g", group = "goto" },
            { "<leader>gd", desc = "Go to definition (same buffer)" },
            { "<leader>gD", desc = "Go to declaration (same buffer)" },
            { "<leader>gi", desc = "Go to implementation (new tab)" },
            { "<leader>gt", desc = "Go to type definition (new tab)" },
            { "<leader>gr", desc = "Find references" },
            { "<leader>fu", desc = "Find usages" },
            { "<leader>l", group = "lsp" },
            { "<leader>lr", desc = "References (telescope)" },
            { "<leader>ls", desc = "Document symbols" },
            { "<leader>lS", desc = "Workspace symbols" },
            { "<leader>ld", desc = "Diagnostics" },
            { "<leader>r", group = "refactor" },
            { "<leader>rn", desc = "Rename symbol" },
            { "<leader>c", group = "code" },
            { "<leader>ca", desc = "Code actions" },
            { "<leader>cc", desc = "Copy line to clipboard" },
            -- Diagnostics/Debug group
            { "<leader>d", group = "diagnostics/debug" },
            { "<leader>de", desc = "Show diagnostic popup" },
            { "<leader>db", desc = "Debug: Toggle breakpoint" },
            { "<leader>dl", desc = "Debug: Step into" },
            { "<leader>dj", desc = "Debug: Step over" },
            { "<leader>dk", desc = "Debug: Step out" },
            { "<leader>dc", desc = "Debug: Continue" },
            { "<leader>dd", desc = "Debug: Conditional breakpoint" },
            { "<leader>dx", desc = "Debug: Terminate" },
            { "<leader>dr", desc = "Debug: Run last" },
            { "<leader>dt", desc = "Debug: Run testables" },
            -- Harpoon group
            { "<leader>a", desc = "Harpoon: Add file", icon = "♥" },
            { "<leader>e", desc = "Harpoon: Toggle menu", icon = "♥" },
            { "<leader>1", desc = "Harpoon: Select 1", icon = "1" },
            { "<leader>2", desc = "Harpoon: Select 2", icon = "2" },
            { "<leader>3", desc = "Harpoon: Select 3", icon = "3" },
            { "<leader>4", desc = "Harpoon: Select 4", icon = "4" },
            -- Workspace group
            { "<leader>w", group = "workspace" },
            { "<leader>wa", desc = "Add workspace folder" },
            { "<leader>wr", desc = "Remove workspace folder" },
            { "<leader>wl", desc = "List workspace folders" },
            -- Quickfix/Location
            { "<leader>q", desc = "Open diagnostics in location list" },
            { "<leader>k", desc = "Next location list" },
            { "<leader>j", desc = "Previous location list" },
            -- Utilities
            { "<leader>u", desc = "Toggle undotree" },
            { "<leader>mx", desc = "Make file executable" },
            { "<leader>f", desc = "Format buffer" },
            { "<leader>sh", desc = "Signature help" },
            -- Top-level single keys
            { "gd", desc = "Go to definition (new tab)" },
            { "gD", desc = "Go to declaration" },
            { "K", desc = "Hover documentation" },
            { "<F2>", desc = "Rename symbol" },
            { "<C-p>", desc = "Git files" },
            { "<C-f>", desc = "Tmux session switcher" },
            { "<C-k>", desc = "Next quickfix item" },
            { "<C-j>", desc = "Previous quickfix item" },
            -- Diagnostics navigation
            { "]d", desc = "Next diagnostic" },
            { "[d", desc = "Previous diagnostic" },
            -- Visual mode mappings
            { "<leader>c", desc = "Copy to clipboard", mode = "v" },
            { "<leader>ca", desc = "Code actions", mode = "v" },
            { "J", desc = "Move line down", mode = "v" },
            { "K", desc = "Move line up", mode = "v" },
            { "<", desc = "Indent left", mode = "v" },
            { ">", desc = "Indent right", mode = "v" },
        },
        -- Show a warning when issues were detected with your mappings
        notify = true,
        -- Triggers for showing the popup
        triggers = {
            { "<auto>", mode = "nxso" },
        },
        -- Plugin configuration
        plugins = {
            marks = true, -- shows marks on ' and `
            registers = true, -- shows registers on " in normal mode
            spelling = {
                enabled = true, -- z= for spelling suggestions
                suggestions = 20,
            },
            presets = {
                operators = true, -- help for d, y, etc.
                motions = true, -- help for motions
                text_objects = true, -- help for text objects
                windows = true, -- help for <c-w>
                nav = true, -- misc bindings for windows
                z = true, -- bindings for folds, spelling
                g = true, -- bindings for g prefix
            },
        },
        -- Window configuration
        win = {
            border = "rounded",
            padding = { 1, 2 },
            title = true,
            title_pos = "center",
            zindex = 1000,
        },
        -- Layout configuration
        layout = {
            width = { min = 20 },
            spacing = 3,
        },
        -- Keys for navigation within the popup
        keys = {
            scroll_down = "<c-d>",
            scroll_up = "<c-u>",
        },
        -- Sorting of mappings
        sort = { "local", "order", "group", "alphanum", "mod" },
        -- Icon configuration
        icons = {
            breadcrumb = "»",
            separator = "➜",
            group = "+",
            ellipsis = "…",
            mappings = true, -- use icons from rules and spec
            colors = true, -- use mini.icons colors
            keys = {
                Up = " ",
                Down = " ",
                Left = " ",
                Right = " ",
                C = " ",
                M = " ",
                S = " ",
                CR = " ",
                Space = " ",
                Tab = " ",
            },
        },
        show_help = true,
        show_keys = true,
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
}
