require('avante_lib').load()
require('avante').setup ({
  provider = "copilot",
  file_selector = {
    --- @alias FileSelectorProvider "native" | "fzf" | "mini.pick" | "telescope" | string
    provider = "fzf",
    -- Options override for custom providers
    provider_opts = {},
  },
  compat = {
    "avante_commands",
    "avante_mentions",
    "avante_files",
  }
})
