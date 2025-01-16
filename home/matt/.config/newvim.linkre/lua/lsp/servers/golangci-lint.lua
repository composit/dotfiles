-- Setup language server.
local lspconfig = require('lspconfig')

-- golangci-lint
lspconfig.golangci_lint_ls.setup{
  cmd = {'golangci-lint-langserver', '-debug'},
  init_options = {
    command = { "golangci-lint", "run", "--config", "~/golangci.yml", "--build-tags", "integration", "--out-format", "json", "--issues-exit-code=1" }
  }
}
