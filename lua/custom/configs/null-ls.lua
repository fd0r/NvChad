local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local opts = {}

local b = null_ls.builtins

local sources = {
  -- python
  b.diagnostics.mypy,
  b.diagnostics.ruff,
  b.formatting.black,

  -- webdev stuff
  b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  b.formatting.prettier.with { filetypes = { "html", "markdown", "css" } }, -- so prettier works only on these filetypes

  -- Lua
  b.formatting.stylua,

  -- cpp
  b.formatting.clang_format,

  -- Tex
  b.formatting.latexindent,
  b.diagnostics.chktex,
  b.diagnostics.proselint,
  b.diagnostics.textidote,
  b.diagnostics.vale.with {
    extra_args = { "--config=/Users/luismontero/.config/vale/.vale.ini" },
  },
}

null_ls.setup {
  debug = true,
  sources = sources,
  on_init = function(new_client, _)
    new_client.offset_encoding = "utf-32"
  end,
}

return opts
