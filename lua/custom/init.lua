-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
--

-- require'mason-lspconfig'.pyright.setup{}

-- local lspconfig = require('nvim-lspconfig');

-- Big hack to get the correct env for the lsp
local conda_env = os.getenv "CONDA_PREFIX"
if conda_env then
  print(conda_env)
  vim.g.python3_host_prog = conda_env .. "/bin/python"
end

local action_triggered = false
local setup_python_for_zama = function()
  -- Global flag to track if action has been performed
  -- Autocommand to trigger action on the first Python file
  vim.cmd [[
      augroup FirstPythonFile
      autocmd!
      autocmd BufEnter *.py call v:lua.CheckAndTriggerAction()
      augroup END
  ]]
  -- Function to check and trigger the action
  function _G.CheckAndTriggerAction()
    if not action_triggered and vim.bo.filetype == "python" then
      -- Perform your desired action here
      -- For example, you can call a function or run a command
      vim.api.nvim_command ":PyrightSetPythonPath /Users/luismontero/miniforge3/envs/zama/bin/python"
      -- Set the flag to true to indicate that the action has been triggered
      action_triggered = true
    end
  end
end

local conda_env_path = os.getenv "CONDA_PREFIX"
local zama_root_dir = vim.fs.dirname(vim.fs.find({ "zama" }, { upward = true })[0])
if conda_env_path then
  print "in zama conda env"
  setup_python_for_zama()
elseif zama_root_dir then
  print "in zama work dir"
  setup_python_for_zama()
end
