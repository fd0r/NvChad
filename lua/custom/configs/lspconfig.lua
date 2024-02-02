local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "clangd", "rust_analyzer", "lua_ls", "pyright"}

for _, lsp in ipairs(servers) do
  -- Lua-ls
  if lsp == "lua_ls" then
    lspconfig[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          -- Set this to avoid warnings when configuring neovim
          -- TODO: make this folder specific
          diagnostics = {
            globals = { "vim" },
          },
        },
      },
    }
  -- Pyright
  elseif lsp == "pyright" then
    lspconfig[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
      -- Specific things
      cmd = { "pyright-langserver", "--stdio" },
      root_dir = function(startpath)
        -- Maybe we should make it start from startpath instead of vim.fs
        local project_path = vim.fs.dirname(vim.fs.find({ "setup.py", "pyproject.toml" }, { upward = true })[1])
        return project_path
      end,
    }
  -- Others
  else
    lspconfig[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end
end
