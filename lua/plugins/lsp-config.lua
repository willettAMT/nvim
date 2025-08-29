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
                opts = {
                    sources = {
                        default = { "lazydev", "lsp", "path", "buffer" },
                        providers = {
                            lazydev = {
                                name = "LazyDev",
                                module = "lazydev.integrations.blink",
                                score_offset = 100,
                            },
                        },
                    },
                },
            },
            {
                "folke/lazydev.nvim",
                ft = "lua",
                opts = {
                    library = {
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
        },
        lazy = false,
        config = function()
            vim.lsp.set_log_level('ERROR')
            local capabilities = require('blink.cmp').get_lsp_capabilities()
            local lspconfig = require("lspconfig")

            -- Vim-friendly on_attach function
            local function on_attach(client, bufnr)
                local opts = { buffer = bufnr, silent = true }

                -- Custom function to open definition in new tab (FIXED - Auto-detect encoding)
                local function goto_definition_new_tab()
                    -- Get the preferred encoding from active LSP client
                    local clients = vim.lsp.get_clients({ bufnr = 0 })
                    local encoding = 'utf-8' -- Default fallback

                    if #clients > 0 then
                        -- Use the first client's offset encoding preference
                        local client = clients[1]
                        if client.offset_encoding then
                            encoding = client.offset_encoding
                        end
                    end

                    local params = vim.lsp.util.make_position_params(0, encoding)
                    vim.lsp.buf_request(0, 'textDocument/definition', params, function(err, result, _)
                        if err or not result or vim.tbl_isempty(result) then
                            print("No definition found")
                            return
                        end

                        local location = result[1] or result
                        if location.uri then
                            local target_file = vim.uri_to_fname(location.uri)
                            local target_line = location.range.start.line + 1
                            local target_col = location.range.start.character + 1

                            vim.cmd('tabnew ' .. vim.fn.fnameescape(target_file))
                            vim.api.nvim_win_set_cursor(0, { target_line, target_col - 1 })
                        end
                    end)
                end

                local function goto_implementation_new_tab()
                    local clients = vim.lsp.get_clients({ bufnr = 0 })
                    local encoding = 'utf-8'
                    if #clients > 0 and clients[1].offset_encoding then
                        encoding = clients[1].offset_encoding
                    end

                    local params = vim.lsp.util.make_position_params(0, encoding)
                    vim.lsp.buf_request(0, 'textDocument/implementation', params, function(err, result, _)
                        if err or not result or vim.tbl_isempty(result) then
                            vim.lsp.buf.implementation()
                            return
                        end

                        local location = result[1] or result
                        if location.uri then
                            local target_file = vim.uri_to_fname(location.uri)
                            local target_line = location.range.start.line + 1
                            local target_col = location.range.start.character + 1

                            vim.cmd('tabnew ' .. vim.fn.fnameescape(target_file))
                            vim.api.nvim_win_set_cursor(0, { target_line, target_col - 1 })
                        end
                    end)
                end

                local function goto_type_definition_new_tab()
                    local clients = vim.lsp.get_clients({ bufnr = 0 })
                    local encoding = 'utf-8'
                    if #clients > 0 and clients[1].offset_encoding then
                        encoding = clients[1].offset_encoding
                    end

                    local params = vim.lsp.util.make_position_params(0, encoding)
                    vim.lsp.buf_request(0, 'textDocument/typeDefinition', params, function(err, result, _)
                        if err or not result or vim.tbl_isempty(result) then
                            vim.lsp.buf.type_definition()
                            return
                        end

                        local location = result[1] or result
                        if location.uri then
                            local target_file = vim.uri_to_fname(location.uri)
                            local target_line = location.range.start.line + 1
                            local target_col = location.range.start.character + 1

                            vim.cmd('tabnew ' .. vim.fn.fnameescape(target_file))
                            vim.api.nvim_win_set_cursor(0, { target_line, target_col - 1 })
                        end
                    end)
                end

                -- SAFE Navigation (preserving Vim defaults where important)
                vim.keymap.set('n', 'gd', goto_definition_new_tab, opts)              -- Go to definition in new tab
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)              -- Go to declaration (same buffer)
                vim.keymap.set('n', '<leader>gi', goto_implementation_new_tab, opts)  -- Implementation in new tab
                vim.keymap.set('n', '<leader>gt', goto_type_definition_new_tab, opts) -- Type def in new tab
                vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, opts)       -- References (moved to leader)

                -- Alternative navigation (same buffer versions)
                vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, opts)  -- Definition in same buffer
                vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, opts) -- Declaration in same buffer
                vim.keymap.set('n', '<leader>fu', vim.lsp.buf.references, opts)  -- Find usages

                -- Refactoring (safe keymaps)
                vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)            -- F2 for rename (IntelliJ-like)
                vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)      -- Alternative rename
                vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts) -- Code actions
                vim.keymap.set('v', '<leader>ca', vim.lsp.buf.code_action, opts) -- Code actions in visual mode

                -- Formatting
                vim.keymap.set('n', '<leader>f', function()
                    vim.lsp.buf.format({ async = true })
                end, opts)

                -- Documentation (K is reasonable to override for LSP)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)                  -- Hover documentation
                vim.keymap.set('n', '<leader>K', vim.lsp.buf.signature_help, opts) -- Signature help
                vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)     -- Signature help in insert mode

                -- Diagnostics navigation (safe keymaps)
                vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, opts) -- Show diagnostic popup (avoiding harpoon conflict)
                vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)  -- Add diagnostics to location list

                -- Workspace management (safe keymaps)
                vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
                vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
                vim.keymap.set('n', '<leader>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, opts)

                -- Telescope integrations (safe keymaps)
                local telescope_available, telescope_builtin = pcall(require, 'telescope.builtin')
                if telescope_available then
                    vim.keymap.set('n', '<leader>lr', telescope_builtin.lsp_references, opts)        -- References in telescope
                    vim.keymap.set('n', '<leader>ls', telescope_builtin.lsp_document_symbols, opts)  -- Document symbols
                    vim.keymap.set('n', '<leader>lS', telescope_builtin.lsp_workspace_symbols, opts) -- Workspace symbols
                    vim.keymap.set('n', '<leader>ld', telescope_builtin.diagnostics, opts)           -- All diagnostics
                end

                -- Highlight symbol under cursor (non-conflicting)
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
            end

            -- Enhanced server configurations (same as before)
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
                        "--all-scopes-completion",
                        "--cross-file-rename",
                        "--log=verbose", -- Add logging for debugging
                    },
                    init_options = {
                        usePlaceholders = true,
                        completeUnimported = true,
                        clangdFileStatus = true,
                    },
                    root_dir = require('lspconfig.util').root_pattern(
                        '.clangd',
                        '.clang-tidy',
                        '.clang-format',
                        'compile_commands.json',
                        'compile_flags.txt',
                        'configure.ac',
                        '.git'
                    ),
                },
            }

            -- Setup all servers
            for server, config in pairs(servers) do
                lspconfig[server].setup(config)
            end

            -- Configure diagnostics appearance (modern method for 0.11.3+)
            vim.diagnostic.config({
                virtual_text = {
                    prefix = '●',
                    source = 'if_many', -- boolean or 'if_many' only
                },
                float = {
                    source = 'if_many', -- boolean or 'if_many' only (not 'always')
                    border = 'rounded',
                },
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "󰅚",
                        [vim.diagnostic.severity.WARN] = "󰀪",
                        [vim.diagnostic.severity.HINT] = "󰌶",
                        [vim.diagnostic.severity.INFO] = "",
                    },
                },
                underline = true,
                update_in_insert = false,
                severity_sort = true,
            })

            -- Configure LSP UI
            require('lspconfig.ui.windows').default_options.border = 'rounded'
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
        config = function(_, opts) require 'lsp_signature'.setup(opts) end
    }
}
