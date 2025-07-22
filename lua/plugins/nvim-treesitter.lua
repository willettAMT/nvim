return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ':TSUpdate',
        lazy = false,
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = {
                    "lua",
                    "vim",
                    "vimdoc",
                    "c",
                    "query",
                    "cpp",
                    -- "markdown",
                    -- "json",
                    "javascript",
                    "typescript",
                    "yaml",
                    "toml",
                    -- "html",
                    -- "css",
                    "bash",
                    "python",
                    -- "dockerfile",
                    "lua",
                    "go",
                    "rust",
                    -- "sql",
                },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },

            })
        end,
        },
    }

