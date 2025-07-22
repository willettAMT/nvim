-- Add lualine
return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = "VeryLazy",
    config = function()
        -- Simple LSP function with error checking
        local function lsp_clients()
            local clients = {}
            pcall(function()
                clients = vim.lsp.get_clients({ bufnr = 0 })
            end)
            if #clients == 0 then
                return ""
            end
            local names = {}
            for _, client in ipairs(clients) do
                if client.name then
                    table.insert(names, client.name)
                end
            end
            return table.concat(names, ",")
        end
        -- Simple macro recording function
        local function show_macro_recording()
            local recording_register = vim.fn.reg_recording()
            if recording_register == "" then
                return ""
            else
                return "Recording @" .. recording_register
            end
        end
        require('lualine').setup({
            options = {
                theme = 'auto',
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                globalstatus = true,
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 
                    'branch', 
                    'diff', 
                    'diagnostics' 
                },
                lualine_c = { 
                    {
                        'filename',
                        path = 1,
                        symbols = {
                            modified = '[+]',
                            readonly = '[-]',
                            unnamed = '[No Name]',
                        }
                    },
                    {
                        show_macro_recording,
                        color = { fg = '#ff9e64', gui = 'bold' }
                    }
                },
                lualine_x = { 
                    lsp_clients,
                    'encoding', 
                    'fileformat', 
                    'filetype' 
                },
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {}
            },
        })
    end
}
