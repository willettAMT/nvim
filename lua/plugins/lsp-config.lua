return {
    {
        'mason-org/mason.nvim',
        lazy = false,
        opts = {},
    },
    {
        "mason-org/mason-lspconfig.nvim",
        lazy = false,
        opts = {
            ensure_installed = {
                "lua_ls",
                "gopls",
                "pyright",
                "ts_ls",
                "rust_analyzer",
                "clangd"
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                'saghen/blink.cmp',
                -- optional blink completion source for require statements and module annotations
                opts = {
                    sources = {
                        -- add lazydev to your completion providers
                        default = { "lazydev", "lsp", "path", "buffer" },
                        providers = {
                            lazydev = {
                                name = "LazyDev",
                                module = "lazydev.integrations.blink",
                                -- make lazydev completions top priority (see `:h blink.cmp`)
                                score_offset = 100,
                            },
                        },
                    },
                },
            },
            {
                "folke/lazydev.nvim",
                ft = "lua", -- only load on lua files
                opts = {
                    library = {
                        -- See the configuration section for more details
                        -- Load luvit types when the `vim.uv` word is found
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
        },
        lazy = false,
        config = function()
            local capabilities = require('blink.cmp').get_lsp_capabilities()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({ capabilities = capabilities })
            lspconfig.pyright.setup({})
            lspconfig.ts_ls.setup({})
            lspconfig.rust_analyzer.setup({})
            lspconfig.clangd.setup({})
        end
    },
}

