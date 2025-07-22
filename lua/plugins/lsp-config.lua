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
            -- Enhanced on_attach function with IntelliJ-like keymaps
            local function on_attach(client, bufnr)
                local opts = { buffer = bufnr, silent = true }
                 -- Custom function to open definition in new tab
                local function goto_definition_new_tab()
                    vim.cmd('tabnew')
                    vim.lsp.buf.definition()
                end
                local function goto_implementation_new_tab()
                    vim.cmd('tabnew')
                    vim.lsp.buf.implementation()
                end
                local function goto_type_definition_new_tab()
                    vim.cmd('tabnew')
                    vim.lsp.buf.type_definition()
                end-- Navigation (IntelliJ-like)
               -- SAFE Navigation (preserving Vim defaults where important)
                vim.keymap.set('n', 'gd', goto_definition_new_tab, opts) -- Go to definition in new tab
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts) -- Go to declaration (same buffer)
                vim.keymap.set('n', '<leader>gi', goto_implementation_new_tab, opts) -- Implementation in new tab
                vim.keymap.set('n', '<leader>gt', goto_type_definition_new_tab, opts) -- Type def in new tab
                vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, opts) -- References (moved to leader)                -- IntelliJ-style shortcuts
                vim.keymap.set('n', '<leader>fu', vim.lsp.buf.references, opts) -- Find usages (changed from C-u)
                -- Refactoring (IntelliJ-like)
                vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts) -- F2 for rename (IntelliJ default)
                vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts) -- Alternative rename
                vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts) -- Code actions
                vim.keymap.set('v', '<leader>ca', vim.lsp.buf.code_action, opts) -- Code actions in visual mode
                -- Quick fixes and formatting
                vim.keymap.set('n', '<leader>f', function()
                    vim.lsp.buf.format({ async = true })
                end, opts)
                -- Documentation and diagnostics
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts) -- Hover documentation
                vim.keymap.set('n', '<leader>sh', vim.lsp.buf.signature_help, opts) -- Signature help (changed from C-k)
                vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help, opts) -- Signature help in insert mode (changed from C-k)
                -- Diagnostics navigation
                vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, opts) -- Show diagnostic popup (changed from leader+e)
                vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts) -- Add diagnostics to location list
                -- Workspace management
                vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
                vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
                vim.keymap.set('n', '<leader>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, opts)
                -- Advanced telescope integrations (if you have telescope)
                local telescope_available, telescope_builtin = pcall(require, 'telescope.builtin')
                if telescope_available then
                    -- Better LSP pickers with telescope
                    vim.keymap.set('n', '<leader>lr', telescope_builtin.lsp_references, opts) -- References in telescope
                    vim.keymap.set('n', '<leader>ls', telescope_builtin.lsp_document_symbols, opts) -- Document symbols
                    vim.keymap.set('n', '<leader>lS', telescope_builtin.lsp_workspace_symbols, opts) -- Workspace symbols
                    vim.keymap.set('n', '<leader>ld', telescope_builtin.diagnostics, opts) -- All diagnostics
                end
                -- Highlight symbol under cursor (IntelliJ-like)
                if client.server_capabilities.documentHighlightProvider then
                    local group = vim.api.nvim_create_augroup("LSPDocumentHighlight", { clear = true })
                    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                        group = group,
                        buffer = bufnr,
                        callback = vim.lsp.buf.document_highlight,
                    })
                    vim.api.nvim_create_autocmd("CursorMoved", {
                        group = group,
                        buffer = bufnr,
                        callback = vim.lsp.buf.clear_references,
                    })
                end
                -- Show function signature while typing
                if client.server_capabilities.signatureHelpProvider then
                    require('lsp_signature').on_attach({
                        bind = true,
                        handler_opts = {
                            border = "rounded"
                        }
                    }, bufnr)
                end
            end
            -- Enhanced server configurations
            local servers = {
                lua_ls = {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = {
                        Lua = {
                            runtime = { version = 'LuaJIT' },
                            diagnostics = { globals = { 'vim' } },
                            workspace = {
                                library = vim.api.nvim_get_runtime_file("", true),
                                checkThirdParty = false,
                            },
                            telemetry = { enable = false },
                        },
                    },
                },
                pyright = {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = {
                        python = {
                            analysis = {
                                autoSearchPaths = true,
                                useLibraryCodeForTypes = true,
                                diagnosticMode = "workspace",
                            },
                        },
                    },
                },
                ts_ls = {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = {
                        typescript = {
                            inlayHints = {
                                includeInlayParameterNameHints = 'all',
                                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                                includeInlayFunctionParameterTypeHints = true,
                                includeInlayVariableTypeHints = true,
                                includeInlayPropertyDeclarationTypeHints = true,
                                includeInlayFunctionLikeReturnTypeHints = true,
                                includeInlayEnumMemberValueHints = true,
                            }
                        },
                        javascript = {
                            inlayHints = {
                                includeInlayParameterNameHints = 'all',
                                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                                includeInlayFunctionParameterTypeHints = true,
                                includeInlayVariableTypeHints = true,
                                includeInlayPropertyDeclarationTypeHints = true,
                                includeInlayFunctionLikeReturnTypeHints = true,
                                includeInlayEnumMemberValueHints = true,
                            }
                        }
                    },
                },
                rust_analyzer = {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = {
                        ["rust-analyzer"] = {
                            cargo = { allFeatures = true },
                            checkOnSave = {
                                command = "clippy",
                                extraArgs = { "--no-deps" },
                            },
                            procMacro = {
                                enable = true,
                                ignored = {
                                    leptos_macro = {
                                        "component",
                                        "server",
                                    },
                                },
                            },
                        },
                    },
                },
                gopls = {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = {
                        gopls = {
                            analyses = {
                                unusedparams = true,
                            },
                            staticcheck = true,
                            gofumpt = true,
                        },
                    },
                },
                clangd = {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    cmd = {
                        "clangd",
                        "--background-index",
                        "--clang-tidy",
                        "--header-insertion=iwyu",
                        "--completion-style=detailed",
                        "--function-arg-placeholders",
                        "--fallback-style=llvm",
                    },
                },
            }
            -- Setup all servers
            for server, config in pairs(servers) do
                lspconfig[server].setup(config)
            end
            -- Configure diagnostics appearance
            vim.diagnostic.config({
                virtual_text = {
                    prefix = '●',
                    source = 'if_many',
                },
                float = {
                    source = true,
                    border = 'rounded',
                },
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
            })
            -- Configure LSP UI
            require('lspconfig.ui.windows').default_options.border = 'rounded'
            -- Diagnostic signs
            local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end
        end
    },
    -- Optional: Enhanced signature help
    {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        opts = {
            bind = true,
            handler_opts = {
                border = "rounded"
            }
        },
        config = function(_, opts) require'lsp_signature'.setup(opts) end
    }
}
