return {
    -- Tokyo night theme
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        -- your config
        require('tokyonight').setup({
            style = "night",
            transparent = false,
            on_colors = function(colors)
                colors.bg = "#1f202e"
            end
        })
        vim.cmd([[colorscheme tokyonight]])
    end,
}
