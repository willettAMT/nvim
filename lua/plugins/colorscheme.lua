return {
    "rebelot/kanagawa.nvim", name = "kanagawa",
    lazy = false,
    --default in nvim is 50
    priority = 1000,
    dark_variant = "main",
    transparent = true,

    enable = {
        dim_inactive_windows = true,
    },

    config = function ()
        vim.cmd('colorscheme kanagawa')
    end
}

