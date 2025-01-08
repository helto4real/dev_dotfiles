return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
    },
        keys = {
            {
                "<leader>ff",
                function() require('fzf-lua').files({}) end,
                desc = "(F)ind (f)iles",
            },
            {
                "<leader>fr",
                function() require('fzf-lua').live_grep_native({}) end,
                desc = "(F)ind with (G)rep",
            },
            {
                "<leader><space>",
                function() require('fzf-lua').buffers({}) end,
                desc = "(F)ind open (space)Buffers",
            },
            {
                "<leader>fg",
                function() require('fzf-lua').git_files({}) end,
                desc = "(F)ind with (G)it files",
            },
            {
                "<leader>fdd",
                function() require('fzf-lua').lsp_document_diagnostics({}) end,
                desc = "(F)ind (D)iagnistics (D)ocument",
            },
            {
                "<leader>fdw",
                function() require('fzf-lua').lsp_workspace_diagnostics({}) end,
                desc = "(F)ind (D)iagnistic (W)orkspace",
            },
            {
                "<leader>fq",
                function() require('fzf-lua').quickfix({}) end,
                desc = "(F)ind in (Q)uickfix list",
            },
            {
                "<leader>fh",
                function() require('fzf-lua').helptags({}) end,
                desc = "(F)ind in (H)elp tags",
            },
            {
                "<leader>fls",
                function() require('fzf-lua').lsp_live_workspace_symbols({}) end,
                desc = "(F)ind (L)sp (S)ymbols",
            },
            {
                "<leader>flw",
                function() require('fzf-lua').lsp_live_document_symbols({}) end,
                desc = "(F)ind (L)sp (W)orkspace symbols",
            },
            {
                "<leader>flc",
                function() require('fzf-lua').lsp_code_actions({}) end,
                desc = "(F)ind (L)sp (C)ode actions",
            },
            {
                "<leader>fk",
                function() require('fzf-lua').keymaps({}) end,
                desc = "(F)ind (K)eymaps",
            },
            {
                "<leader>/",
                function() require('fzf-lua').lgrep_curbuf({}) end,
                desc = "Find fuzzy in current buffer",
            },
    },
}

--       keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
--         keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
--         keymap.set('n', '<leader>/', function()
--             -- You can pass additional configuration to telescope to change theme, layout, etc.
--             require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
--                 winblend = 10,
--                 previewer = false,
--             })
--         end, { desc = '[/] Fuzzily search in current buffer' })
--
--         keymap.set('n', '<leader>fg', require('telescope.builtin').git_files, { desc = 'Find [G]it files' })
--         keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[F]ind [F]iles' })
--         keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = '[F]ind [H]elp' })
--         keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = '[F]ind current [W]ord' })
--         keymap.set('n', '<leader>fr', require('telescope.builtin').live_grep, { desc = '[F]ind by [G]rep' })
--         keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[F]ind [D]iagnostics' })
--         keymap.set('n', '<leader>fk', require('telescope.builtin').keymaps, { desc = '[F]ind [K]eymap' })
