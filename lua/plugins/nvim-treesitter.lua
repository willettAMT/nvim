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
            "python",
            "c",
            "dockerfile",
            "gitignore",
            "cpp",
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

