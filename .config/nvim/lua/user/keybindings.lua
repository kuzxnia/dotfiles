local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

--- telescope ---
-- vim.api.nvim_set_keymap("n", "<C-f>", "<cmd>lua require('telescope').extensions.frecency.frecency()<CR>", {noremap = true, silent = true})
map('n', '<leader><space>', ':lua telescope_files_or_git_files()<CR>')
map('n', '<leader>fd', ':lua telescope_find_files_in_path()<CR>')
map('n', '<leader>fD', ':lua telescope_live_grep_in_path()<CR>')
-- map('n', "<leader>fe', ':lua telescope_live_grep_in_path('venv')<CR><CR>")
-- map('n', '<leader>ft', ':lua telescope_find_files_in_path("./tests")<CR>')
-- map('n', '<leader>fT', ':lua telescope_live_grep_in_path("./tests")<CR>')
map('n', '<leader>fg', ':lua telescope_live_grep_git()<CR>')
map('n', '<leader>fG', ':Telescope live_grep<CR>')
map('n', '<leader>fo', ':Telescope file_browser<CR>')
map('n', '<leader>ff', ':Telescope find_files<CR>')
map('n', '<leader>fb', ':Telescope buffers<CR>')
-- for which-key display
map('n', '<leader>b', ':Telescope buffers<CR>')
map('n', '<leader>fs', ':Telescope lsp_document_symbols<CR>')
map('n', '<leader>fbb', ':Telescope git_branches<CR>')
map('n', '<leader>lr', ':Telescope lsp_references<CR>')
map('n', '<leader>ld', ':Telescope lsp_definitions<CR>')
map('n', '<leader>lw', ':Telescope lsp_workspace_symbols<CR>')
map('n', '<leader>lc', ':Telescope lsp_code_actions<CR>')


--- tmux navigator ---
vim.api.nvim_set_keymap('n', '<M-h>', ':TmuxNavigateLeft<CR>',  {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<M-j>', ':TmuxNavigateDown<CR>',  {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<M-k>', ':TmuxNavigateUp<CR>',    {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<M-l>', ':TmuxNavigateRight<CR>', {noremap = true, silent = true})

-- Copy to clipboard
vim.api.nvim_set_keymap("v", "<leader>y", '"+y', {expr = true})
vim.api.nvim_set_keymap("n", "<leader>Y", '"+yg_', {expr = true})
vim.api.nvim_set_keymap("n", "<leader>y", '"+y', {expr = true})
vim.api.nvim_set_keymap("n", "<leader>yy", '"+yy', {expr = true})

-- Paste from clipboard
vim.api.nvim_set_keymap("n", "<leader>p", '"+p', {expr = true})
vim.api.nvim_set_keymap("n", "<leader>P", '"+P', {expr = true})
vim.api.nvim_set_keymap("v", "<leader>p", '"+p', {expr = true})
vim.api.nvim_set_keymap("v", "<leader>P", '"+P', {expr = true})

-- better indenting
vim.api.nvim_set_keymap('v', '<', '<gv', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '>', '>gv', {noremap = true, silent = true})

-- Move selected line / block of text in visual mode
vim.api.nvim_set_keymap('x', 'K', ':move \'<-2<CR>gv-gv', {noremap = true, silent = true})
vim.api.nvim_set_keymap('x', 'J', ':move \'>+1<CR>gv-gv', {noremap = true, silent = true})

-- kommentary
vim.api.nvim_set_keymap("n", "<leader>cc", "<Plug>kommentary_line_default", {})
vim.api.nvim_set_keymap("n", "<leader>c", "<Plug>kommentary_motion_default", {})
vim.api.nvim_set_keymap("x", "<leader>c", "<Plug>kommentary_visual_default", {})

-- tree
vim.api.nvim_set_keymap("n", "<Leader>e", ":NvimTreeToggle<CR>", {noremap = true, silent = true})
