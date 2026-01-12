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
        keymap.set("n", "<leader>e", function() local harpoon = require("harpoon") harpoon.ui:toggle_quick_menu(harpoon:list()) end),
        -- select buffer
        keymap.set("n", "<leader>1", function() require("harpoon"):list():select(1) end),
        keymap.set("n", "<leader>2", function() require("harpoon"):list():select(2) end),
        keymap.set("n", "<leader>3", function() require("harpoon"):list():select(3) end),
        keymap.set("n", "<leader>4", function() require("harpoon"):list():select(4) end),
        -- toggle previous & next buffers stored within Harpoon list
        keymap.set("n", "<leader>hp", function() require("harpoon"):list():prev() end),
        keymap.set("n", "<leader>he", function() require("harpoon"):list():next() end),
    },
}
