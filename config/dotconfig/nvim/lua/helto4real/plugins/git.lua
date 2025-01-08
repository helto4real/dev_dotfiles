return {
    {
        'tpope/vim-fugitive',
        event = "VeryLazy",
    },
    {
        'tpope/vim-rhubarb',
        event = "VeryLazy",
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        opts = {},
    },
    {
        'pwntester/octo.nvim',
        event = "VeryLazy",
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            require "octo".setup()
        end,
        keys = {
            {
                "<leader>ghrb",
                "<cmd>Octo repo browser<CR>",
                desc = "(G)it(H)ub (R)epo (B)rowser",
            },
            {
                "<leader>ghrl",
                "<cmd>Octo repo list<CR>",
                desc = "(G)it(H)ub (R)epo (L)ist",
            },
            {
                "<leader>ghrv",
                "<cmd>Octo repo view<CR>",
                desc = "(G)it(H)ub (R)epo (V)iew",
            },
            {
                "<leader>ghil",
                "<cmd>Octo issue list<CR>",
                desc = "(G)it(H)ub (I)ssue (L)ist",
            },
            {
                "<leader>ghpl",
                "<cmd>Octo pr list<CR>",
                desc = "(G)it(H)ub (P)R (L)ist",
            },
            {
                "<leader>ghpn",
                "<cmd>Octo pr create<CR>",
                desc = "(G)it(H)ub (P)R create(N)",
            },
            {
                "<leader>ghpc",
                "<cmd>Octo pr changes<CR>",
                desc = "(G)it(H)ub (P)R (C)hanges",
            },
            {
                "<leader>ghpb",
                "<cmd>Octo pr browser<CR>",
                desc = "(G)it(H)ub (P)R (B)rowser",
            },
            {
                "<leader>ghph",
                "<cmd>Octo pr checkout<CR>",
                desc = "(G)it(H)ub (P)R c(H)echout",
            },
            {
                "<leader>ghpru",
                "<cmd>Octo pr s(U)mit<CR>",
                desc = "(G)it(H)ub (P)R s(U)ubmit",
            },
            {
                "<leader>ghprs",
                "<cmd>Octo pr review start<CR>",
                desc = "(G)it(H)ub (P)R (R)eview (S)tart",
            },
            {
                "<leader>ghpre",
                "<cmd>Octo pr review checks<CR>",
                desc = "(G)it(H)ub (P)R (R)eview (C)hecks",
            },
            {
                "<leader>ghprr",
                "<cmd>Octo pr review resume<CR>",
                desc = "(G)it(H)ub (P)R (R)eview (R)esume",
            },
            {
                "<leader>ghprm",
                "<cmd>Octo pr review comment<CR>",
                desc = "(G)it(H)ub (P)R (R)eview co(M)ent",
            },
            {
                "<leader>ghprx",
                "<cmd>Octo pr review close<CR>",
                desc = "(G)it(H)ub (P)R (R)eview close(X)",
            },
            {
                "<leader>ghprd",
                "<cmd>Octo pr review discard<CR>",
                desc = "(G)it(H)ub (P)R (R)eview (D)iscard",
            },
            {
                "<leader>ghpro",
                "<cmd>Octo pr review commit<CR>",
                desc = "(G)it(H)ub (P)R (R)eview c(O)mmit",
            },
        },
    },
    {
        "NeogitOrg/neogit",
        keys = {
            {
                "<leader>gg",
                function()
                    require("neogit").open({ kind = "split" })
                end,
                desc = "(G)it Neo(g)it",
            },
            {
                "<leader>gc",
                function()
                    require("neogit").open({ "commit", "-a", kind = "split"})
                end,
                desc = "(G)it (C)ommit",
            },
            {
                "<leader>gd",
                function()
                    require("neogit").open({ "diff", kind = "split"})
                end,
                desc = "(G)it (D)iff",
            },
            {
                "<leader>gp",
                function()
                    require("neogit").open({ "push" })
                end,
                desc = "(G)it (P)ush",
            },
            {
                "<leader>gw",
                function()
                    require("neogit").open({ "worktree" })
                end,
                desc = "(G)it (W)orktree",
            },
            {
                "<leader>gb",
                function()
                    require("neogit").open({ "branch" })
                end,
                desc = "(G)it (B)ranch",
            },
            {
                "<leader>gr",
                function()
                    require("neogit").open({ "rebase" })
                end,
                desc = "(G)it (R)ebase",
            },
        },
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",  -- required
            "sindrets/diffview.nvim", -- optional - Diff integration

            -- Only one of these is needed, not both.
            "nvim-telescope/telescope.nvim", -- optional
        },
        config = true
    }
}
