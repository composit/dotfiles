-- Setup language server.
local lspconfig = require('lspconfig')
local capabilities = require('blink.cmp').get_lsp_capabilities()

-- gopls
lspconfig.gopls.setup({
  settings = {
    gopls = {
      gofumpt = true,
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
	org_imports()
        vim.lsp.buf.format({ async = false })
        --vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true }) -- this would be better than org_imports, and it seems to work, but outputs "no code actions available"
	--vim.lsp.buf.code_action({ context = { only = { 'source.fixAll' } }, apply = true }) -- not sure what this does
      end,
    })
  end
})

function org_imports()
  local clients = vim.lsp.buf_get_clients()
  for _, client in pairs(clients) do

    local params = vim.lsp.util.make_range_params(nil, client.offset_encoding)
    params.context = {only = {"source.organizeImports"}}

    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 5000)
    for _, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, client.offset_encoding)
        else
          vim.lsp.buf.execute_command(r.command)
        end
      end
    end
  end
end
