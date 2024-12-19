local keymap = vim.keymap

return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false,
    config = function()
        require("harpoon"):setup()
    end,
    keys = {
        -- add buffer && toggle menu
        keymap.set("n", "<leader>a", function() require("harpoon"):list():add() end),
        keymap.set("n", "<C-e>", function() local harpoon = require("harpoon") harpoon.ui:toggle_quick_menu(harpoon:list()) end),
        -- select buffer
        keymap.set("n", "<C-i>", function() require("harpoon"):list():select(1) end),
        keymap.set("n", "<C-j>", function() require("harpoon"):list():select(2) end),
        keymap.set("n", "<C-l>", function() require("harpoon"):list():select(3) end),
        keymap.set("n", "<C-k>", function() require("harpoon"):list():select(4) end),
        -- toggle previous & next buffers stored within Harpoon list
        keymap.set("n", "<C-l>", function() require("harpoon"):list():prev() end),
        keymap.set("n", "<C-n>", function() require("harpoon"):list():next() end),
    },
}
