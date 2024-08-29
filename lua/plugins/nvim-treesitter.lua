local config = function()
    require("nvim-treesitter.configs").setup({
        indent = {
            enable = true,
        },
        autotag = {
            enable = true,
        },
        sync_install = false,
        ensure_installed = {
            "markdown",
            "json",
            "javascript",
            "typescript",
            "yaml",
            "toml",
            "html",
            "css",
            "markdown",
            "bash",
            "lua",
            "dockerfile",
            "gitignore",
            "python",
            "c",
<<<<<<< HEAD
=======
            "cpp",
>>>>>>> 0d46229 (init commit & new color scheme)
            "zig",
            "sql",
            "ocaml",
            "lua",
            "go",
            "rust",
        },
        auto_install = true,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
    })
end

return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    config = config
}

