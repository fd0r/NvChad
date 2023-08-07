local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "clangd" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

local zama_on_attach = function()
  -- Custom on attach function that call the change of python interpreter if on a zama project
  -- Temporary solution until I can find why pyright doesn't attach to the current env python 
  -- interpreter
  
  return onattach()
end

lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "pyright-langserver", "--stdio" },
  root_dir = function(startpath)
    -- Maybe we should make it start from startpath instead of vim.fs
    local project_path = vim.fs.dirname(vim.fs.find({ "setup.py", "pyproject.toml" }, { upward = true })[1])
    return project_path
  end,
}
