return {
    'akinsho/toggleterm.nvim',
    event = "VeryLazy",
    config = function()
        require("toggleterm").setup()
        local keymap = vim.keymap -- for conciseness
        keymap.set("n", "<leader>tt", ":ToggleTerm size=50 direction=vertical<CR>", { desc = "Toggle [T]erminal", noremap = true, silent = true})
    end
}
