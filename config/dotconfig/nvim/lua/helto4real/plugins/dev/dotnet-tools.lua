return {
    dir = "~/git/dotnet-tools",
    dependencieset = {
        "plenary.nvim",
    },
    init = function()
        require("dotnet-tools").setup({})
    end,
    keys = {
        {
            "<leader>ct",
            mode = { "n", "o", "x" },
            ":DotNetToolsTest<CR>",
            desc = "Dotnet test"
        },
        {
            "<leader>co",
            mode = { "n", "o", "x" },
            ":DotNetToolsOutdated<CR>",
            desc = "Dotnet outdated"
        },
        {
            "<leader>cu",
            mode = { "n", "o", "x" },
            ":DotNetToolsOutdatedUpgrade<CR>",
            desc = "Dotnet outdated upgrade"
        },
        {
            "<leader>cb",
            mode = { "n", "o", "x" },
            ":DotNetToolsBuild<CR>",
            desc = "Dotnet build"
        },
    },
}
