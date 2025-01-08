return {
    "nvim-neotest/neotest",
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "Issafalcon/neotest-dotnet",
    },
    config = function()
        local neotest = require("neotest")
        local neotest_dotnet = require("neotest-dotnet")
        neotest.setup({
            {
                -- add any options here
                log_level = 1,
                adapters = {
                    neotest_dotnet({
                        dicovery_root = "project",
                    }),
                },
                icons = {
                    expanded = "",
                    child_prefix = "",
                    child_indent = "",
                    final_child_prefix = "",
                    non_collapsible = "",
                    collapsed = "",
                    passed = "",
                    running = "",
                    failed = "",
                    unknown = "",
                    skipped = "",
                },
            },
        })
    end,
}
