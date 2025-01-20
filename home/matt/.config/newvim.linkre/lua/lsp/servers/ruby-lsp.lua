require("lspconfig").ruby_lsp.setup({
    cmd = { "path/to/ruby-lsp" },  -- Update this path based on your Ruby version manager
    on_attach = function(client, buffer)
        -- Additional setup can be done here
    end,
})

