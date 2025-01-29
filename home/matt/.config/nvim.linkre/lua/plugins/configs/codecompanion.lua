require("codecompanion").setup({
    strategies = {
        chat = {
            adapter = "copilot",
        },
        inline = {
            enabled = true,
            adapter = "copilot",
        },
    },
})
