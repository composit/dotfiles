local lspconfig = require('lspconfig')
local capabilities = require('blink.cmp').get_lsp_capabilities()

lspconfig.ruby_lsp.setup({
  formatter = 'standard',
  linters = { 'standard' },
  settings = {
    rubocop = {
      lint = true,
      autocorrect = true,
    },
  },
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format()
      end,
    })
  end
})
