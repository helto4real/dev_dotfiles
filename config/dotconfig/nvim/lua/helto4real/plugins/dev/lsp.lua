return {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    -- event = { "BufReadPre", "BufNewFile" },
    event = "VeryLazy",
    dependencies = {
        { 'williamboman/mason.nvim',           event = "VeryLazy" },
        { 'williamboman/mason-lspconfig.nvim', event = "VeryLazy" },
        { "mfussenegger/nvim-lint",            event = "VeryLazy" },
        { "rshkarin/mason-nvim-lint",          event = "VeryLazy" },
        { 'saghen/blink.cmp',                  event = "VeryLazy" },
        -- Show overloads for LSP
        -- { "Issafalcon/lsp-overloads.nvim",             event = "VeryLazy" },
        -- Useful status updates for LSP
        { 'j-hui/fidget.nvim',                 event = "VeryLazy", tag = 'legacy', opts = {} },
        -- Additional lua configuration, makes nvim stuff amazing!
        -- { 'folke/neodev.nvim',                         event = "VeryLazy" },
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
        { "williamboman/mason-lspconfig.nvim",         event = "VeryLazy" },
        { "WhoIsSethDaniel/mason-tool-installer.nvim", event = "VeryLazy" },
        -- { "jmederosalvarado/roslyn.nvim",              event = "VeryLazy" },
        {
            "seblj/roslyn.nvim",
            ft = "cs",
            opts = {
                -- your configuration comes here; leave empty for default settings
            }
        },
        -- { "seblj/roslyn.nvim",                         event = "VeryLazy" },
        {
            "olexsmir/gopher.nvim",
            ft = "go",
            config = function(_, opts)
                require("gopher").setup(opts)
                -- require("core.utils").load_mappings("gopher")
            end,
            build = function()
                vim.cmd [[silent! GoInstallDeps]]
            end,
        },
        -- {
        --     "crispgm/nvim-go",
        --     dependencies = {
        --         "nvim-lua/plenary.nvim",
        --         -- "rcarriga/nvim-notify",
        --     },
        --     config = function()
        --         require('go').setup({
        --             -- notify: use nvim-notify
        --             notify = true,
        --             -- auto commands
        --             auto_format = true,
        --             auto_lint = true,
        --             -- linters: revive, errcheck, staticcheck, golangci-lint
        --             linter = 'revive',
        --             -- linter_flags: e.g., {revive = {'-config', '/path/to/config.yml'}}
        --             linter_flags = {},
        --             -- lint_prompt_style: qf (quickfix), vt (virtual text)
        --             lint_prompt_style = 'vt',
        --             -- formatter: goimports, gofmt, gofumpt
        --             formatter = 'goimports',
        --             -- maintain cursor position after formatting loaded buffer
        --             maintain_cursor_pos = true,
        --             -- test flags: -count=1 will disable cache
        --             test_flags = { '-v' },
        --             test_timeout = '30s',
        --             test_env = {},
        --             -- show test result with popup window
        --             test_popup = true,
        --             test_popup_auto_leave = true,
        --             test_popup_width = 80,
        --             test_popup_height = 10,
        --             -- test open
        --             test_open_cmd = 'edit',
        --             -- struct tags
        --             tags_name = 'json',
        --             tags_options = { 'json=omitempty' },
        --             tags_transform = 'snakecase',
        --             tags_flags = { '-skip-unexported' },
        --             -- quick type
        --             quick_type_flags = { '--just-types' },
        --         })
        --     end,
        --     event = { "CmdlineEnter" },
        --     ft = { "go", 'gomod' },
        --     -- build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
        -- },
        -- { "iabdelkareem/csharp.nvim",                  event = "VeryLazy" },
        -- { "Tastyep/structlog.nvim",                    event = "VeryLazy" },

    },
    config = function()
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
            callback = function(event)
                -- local on_attach = function(client, bufnr)
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                local bufnr = event.buf

                -- for LSP related items. It sets the mode, buffer and description for us each time.
                local nmap = function(keys, func, desc)
                    if desc then
                        desc = 'LSP: ' .. desc
                    end
                    vim.keymap.set('n', keys, func, { noremap = true, silent = true, buffer = bufnr, desc = desc })
                end

                --- Guard against servers without the signatureHelper capability
                -- if client ~= nil and client.server_capabilities.signatureHelpProvider then
                --     require('lsp-overloads').setup(client,
                --     {
                --         ui = {
                --             focusable = false,     -- Make the popup float focusable
                --             focus = false,        -- If focusable is also true, and this is set to true, navigating through overloads will focus into the popup window (probably not what you want)
                --             silent = true, -- Prevents noisy notifications (make false to help debug why signature isn't working)
                --             },
                --         keymaps = {
                --             next_signature = "<C-j>",
                --             previous_signature = "<C-k>",
                --             next_parameter = "<C-l>",
                --             previous_parameter = "<C-h>",
                --             close_signature = "<c-x>",
                --         },
                --         display_automatically = true, -- Uses trigger characters to automatically display the signature overloads when typing a method signature
                --     })
                -- end
                --
                nmap('<leader>ce', '<cmd>Trouble diagnostics toggle focus=false filter.buf=0<CR>', '[e]rrors')
                nmap('<leader>cr', vim.lsp.buf.rename, '[R]ename')
                nmap('<leader>ca', vim.lsp.buf.code_action, 'Code [A]ction')
                nmap('<leader>gd', vim.lsp.buf.definition, '[D]efinition')
                nmap('<leader>gi', vim.lsp.buf.implementation, '[I]mplementation')
                nmap('<leader>gD', vim.lsp.buf.declaration, '[D]eclaration')
                nmap('<leader>cD', vim.lsp.buf.type_definition, 'Type [D]efinition')
                nmap('<leader>fsw', require('fzf-lua').lsp_live_workspace_symbols, '[D]ocument')
                nmap('<leader>fsd', require('fzf-lua').lsp_document_symbols, '[W]orkspace')
                nmap('<leader>fc', require('fzf-lua').lsp_code_actions, '[C]ode Actions')
                nmap('<leader>fI', require('fzf-lua').lsp_incoming_calls, '[I]ncoming calls')
                nmap('<leader>fi', require('fzf-lua').lsp_finder, 'F[i]der')
                nmap('<leader>fR', require('fzf-lua').lsp_references, '[R]eferences')
                nmap('<leader>ft', require('fzf-lua').lsp_typedefs, '[T]ype definitions')
                -- See `:help K` for why this keymap
                nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
                nmap('<leader>ck', vim.lsp.buf.signature_help, 'Signature Documentation')
                -- Lesser used LSP functionality

                -- Workspace related LSP functionality, not used often
                -- nmap('<leader>wwa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
                -- nmap('<leader>wwr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
                -- nmap('<leader>wwl', function()
                --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                -- end, '[W]orkspace [L]ist Folders')
                -- Create a command `:Format` local to the LSP buffer
                vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
                    vim.lsp.buf.format()
                end, { desc = 'Format current buffer with LSP' })

                nmap("<leader>cf", ":Format<CR>", "[F]ormat")
                -- quick fix naviagtion
                --vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
                --vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
                --vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
                --vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
                -- Setup neovim lua configuration

                -- only setup on attach

                -- The following two autocommands are used to highlight references of the
                -- word under your cursor when your cursor rests there for a little while.
                --    See `:help CursorHold` for information about when this is executed
                --
                -- When you move your cursor, the highlights will be cleared (the second autocommand).
                if client and client.server_capabilities.documentHighlightProvider then
                    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                        buffer = event.buf,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                        buffer = event.buf,
                        callback = vim.lsp.buf.clear_references,
                    })
                end
            end,
        })

        -- neodev setup before lspconfig
        -- require('neodev').setup()
        local mason_lspconfig = require("mason-lspconfig")

        local mason_tool_installer = require("mason-tool-installer")


        mason_lspconfig.setup({
            -- list of servers for mason to install
            ensure_installed = {
                -- 'omnisharp',
                -- 'roslyn',
                'html',
                'v_analyzer',
                'lua_ls',
                'yamlls',
                'gopls',
                'jsonls',
                'pyright',
                'bashls',
                -- 'roslyn',
                -- 'rust_analyzer',
            },
            -- auto-install configured servers (with lspconfig)
            automatic_installation = true, -- not the same as ensure_installed
        })
        -- install mason tools
        mason_tool_installer.setup({
            ensure_installed = {
                -- "markdownlint", -- prettier formatter
            },
            automatic_installation = true,
        })
        local lspconfig = require("lspconfig")

        -- used to enable autocompletion (assign to every lsp server config)
        local capabilities = require('blink.cmp').get_lsp_capabilities()

        -- Change the Diagnostic symbols in the sign column (gutter)
        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        -- require('helto4real.autoload.dap')

        -- configure html server
        lspconfig["html"].setup({
            capabilities = capabilities,
            filetypes = { 'html', 'twig', 'hbs' },
            -- on_attach = on_attach,
        })

        lspconfig["bashls"].setup({
            capabilities = capabilities,
            -- filetypes = { 'html', 'twig', 'hbs' },
            -- on_attach = on_attach,
        })
        -- configure lua server
        lspconfig["lua_ls"].setup({
            capabilities = capabilities,
            filetypes = { 'lua' },
            -- on_attach = on_attach,
            settings = {
                Lua = {
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                },
            },
        })

        -- configure v-language server
        lspconfig["v_analyzer"].setup({
            capabilities = capabilities,
            filetypes = { 'v' },
            -- on_attach = on_attach,
        })

        -- configure v-language server
        -- lspconfig["rust_analyzer"].setup({
        --     capabilities = capabilities,
        --     -- filetypes = { 'v' },
        --     -- on_attach = on_attach,
        -- })
        -- configure yaml server
        lspconfig["yamlls"].setup({
            capabilities = capabilities,
            filetypes = { 'yaml', 'yml' },
            -- on_attach = on_attach,
        })

        lspconfig["jsonls"].setup({
            capabilities = capabilities,
            -- filetypes = { 'json' },
            -- on_attach = on_attach,
        })

        lspconfig["pyright"].setup({
            capabilities = capabilities,
            -- filetypes = { 'yaml', 'yml' },
            -- on_attach = on_attach,
        })

        local util = require "lspconfig/util"
        lspconfig["gopls"].setup({
            capabilities = capabilities,
            filetypes = { "go", "gomod", "gowork", "gotmpl" },
            root_dir = util.root_pattern("go.work", "go.mod", ".git"),
            -- filetypes = { 'yaml', 'yml' },
            -- on_attach = on_attach,
        })

        -- configure c# (omnisharp) server
        -- lspconfig["omnisharp"].setup({
        --     capabilities = capabilities,
        --     cmd = { "dotnet", vim.fn.stdpath "data" .. "/mason/packages/omnisharp/libexec/OmniSharp.dll" },
        --     enable_roslyn_analyzers = true,
        --     enable_roslyn_analysers = true,
        --     enable_import_completion = true,
        --     organize_imports_on_format = true,
        --     enable_decompilation_support = true,
        --     root_dir = function()
        --         return vim.loop.cwd() -- current working directory
        --     end,
        --     filetypes = { 'cs' },
        --     -- on_attach = on_attach,
        -- })

        -- require("roslyn").setup({
        --     -- dotnet_cmd = "dotnet", -- this is the default
        --     -- It is a hidden thing, checkout the c# vscode extension for more info
        --     -- https://github.com/dotnet/vscode-csharp/blob/main/package.json#L40
        --
        --     roslyn_version = "4.11.0-3.24320.2", -- this is the default
        --     on_attach = function(client, bufnr)
        --         print("Roslyn attached")
        --     end,
        --     capabilities = capabilities, -- required
        -- })
        -- require("roslyn").setup({
        --     capabilities = capabilities,
        --     config = {
        --         -- Here you can pass in any options that that you would like to pass to `vim.lsp.start`
        --         -- The only options that I explicitly override are, which means won't have any effect of setting here are:
        --         --     - `name`
        --         --     - `cmd`
        --         --     - `root_dir`
        --     },
        --     exe = {
        --         "dotnet",
        --         vim.fs.joinpath(vim.fn.stdpath("data"), "roslyn", "Microsoft.CodeAnalysis.LanguageServer.dll"),
        --     },
        --     -- NOTE: Set `filewatching` to false if you experience performance problems.
        --     -- Defaults to true, since turning it off is a hack.
        --     -- If you notice that the server is _super_ slow, it is probably because of file watching
        --     -- I noticed that neovim became super unresponsive on some large codebases, and that was because
        --     -- it schedules the file watching on the event loop.
        --     -- This issue went away by disabling that capability. However, roslyn will fallback to its own
        --     -- file watching, which can make the server super slow to initialize.
        --     -- Setting this option to false will indicate to the server that neovim will do the file watching.
        --     -- However, in `hacks.lua` I will also just don't start off any watchers, which seems to make the server
        --     -- a lot faster to initialize.
        --     filewatching = true,
        -- })
    end,
}
