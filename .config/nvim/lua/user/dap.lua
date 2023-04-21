local dap = require('dap')

dap.adapters.python = {
  type = 'executable';
  command = vim.loop.cwd() .. '/.venv/bin/python';
  args = { '-m', 'debugpy.adapter' };
}

dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    name = "Django";
    type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch';
    args = {
      "runserver",
      "--nothreading",
      "--noreload"
    };
    program = "${workspaceFolder}/manage.py";
    django = true;
    pythonPath = function()
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        return cwd .. '/venv/bin/python'
      elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        return cwd .. '/.venv/bin/python'
      else
        return '/usr/bin/python'
      end
    end;
  },
}

local function prune_nil(items)
  return vim.tbl_filter(function(x) return x end, items)
end

local test_runners = require('dap-python').test_runners
test_runners.pytest_env = function(classname, methodname)
  local path = vim.fn.expand('%:p')
  local test_path = table.concat(prune_nil({path, classname, methodname}), '::')
  -- -s "allow output to stdout of test"
  local args = {'-s', test_path}
  return 'APP_ENV=testsuite py.test', args
end
require('dap-python').setup(vim.loop.cwd() .. '/.venv/bin/python')
require('dap-python').test_runner = 'pytest_env'

require('nvim-dap-virtual-text').setup()

require("dapui").setup()

vim.fn.sign_define('DapBreakpoint', {text='', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='', texthl='', linehl='', numhl=''})

-- map('n', '<leader>dH', ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
--[[ map('n', '<leader>di', ':lua require"dap.ui.variables".hover()<CR>')
map('n', '<leader>di', ':lua require"dap.ui.variables".visual_hover()<CR>')
map('n', '<leader>d?', ':lua require"dap.ui.variables".scopes()<CR>')
map('n', '<leader>di', ':lua require"dap.ui.widgets".hover()<CR>')
map('n', '<leader>de', ':lua require"dap".set_exception_breakpoints({"all"})<CR>') ]]
-- map('n', '<leader>d?', ':lua local widgets=require"dap.ui.widgets";widgets.centered_float(widgets.scopes)<CR>')

-- nvim-telescope/telescope-dap.nvim
-- map('n', '<leader>ds', ':Telescope dap frames<CR>')

-- theHamsta/nvim-dap-virtual-text and mfussenegger/nvim-dap
-- g.dap_virtual_text = true
