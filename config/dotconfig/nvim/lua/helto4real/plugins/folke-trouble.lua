return {
    "folke/trouble.nvim",
    --dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    keys = {
            {
                mode = { 'n' },
                '<Leader>cr',
                '<cmd>Trouble<cr>',
                desc = '[T]rouble',
            },
    },
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    },
}
