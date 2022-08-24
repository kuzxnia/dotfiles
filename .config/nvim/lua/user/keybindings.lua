local opts = { noremap = true, silent = true }
local expr_opts = { expr = true }

local function map(mode, lhs, rhs, lopts)
  local options = {noremap = true}
  if lopts then options = vim.tbl_extend('force', options, lopts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

--- telescope ---
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
map('n', '<leader>fb', ':Telescope file_browser<CR>')
map('n', '<leader>fs', ':Telescope lsp_document_symbols<CR>')

map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
map("n", "<C-Space>", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
map("n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
map("n", "gl", '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>', opts)
map("n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
map("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

-- for which-key display
map('n', '<leader>b', ':Telescope buffers<CR>')
map('n', '<leader>fs', ':Telescope lsp_document_symbols<CR>')
map('n', '<leader>fbb', ':Telescope git_branches<CR>')
map('n', '<leader>lr', ':Telescope lsp_references<CR>')
map('n', '<leader>ld', ':Telescope lsp_definitions<CR>')
map('n', '<leader>lw', ':Telescope lsp_workspace_symbols<CR>')
map('n', '<leader>lc', ':Telescope lsp_code_actions<CR>')
map('n', '<leader>lf', ':Format<CR>')

--- buffers ---
map('n', 'H', ':BufferLineCyclePrev<CR>', opts)
map('n', 'L', ':BufferLineCycleNext<CR>', opts)
map('n', 'gb', ':BufferLinePick<CR>', opts)
map('n', 'Q', ':Bdelete<CR>', opts)

--- tmux navigator ---
map('n', '<M-h>', ':TmuxNavigateLeft<CR>',  opts)
map('n', '<M-j>', ':TmuxNavigateDown<CR>',  opts)
map('n', '<M-k>', ':TmuxNavigateUp<CR>',    opts)
map('n', '<M-l>', ':TmuxNavigateRight<CR>', opts)

-- Copy to clipboard
map("v", "<leader>y", '"+y', expr_opts)
map("n", "<leader>Y", '"+yg_', expr_opts)
map("n", "<leader>y", '"+y', expr_opts)
map("n", "<leader>yy", '"+yy', expr_opts)

-- Paste from clipboard
map("n", "<leader>p", '"+p', expr_opts)
map("n", "<leader>P", '"+P', expr_opts)
map("v", "<leader>p", '"+p', expr_opts)
map("v", "<leader>P", '"+P', expr_opts)

-- better indenting
map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)

-- Move selected line / block of text in visual mode
map('x', 'K', ':move \'<-2<CR>gv-gv', opts)
map('x', 'J', ':move \'>+1<CR>gv-gv', opts)

-- kommentary
map("n", "<leader>cc", "<Plug>kommentary_line_default", {})
map("n", "<leader>c", "<Plug>kommentary_motion_default", {})
map("x", "<leader>c", "<Plug>kommentary_visual_default", {})

-- search and replace the word under cursor
map("n", "<Leader>*", ":%s/<C-r><C-w>//<Left>", {})

-- tree
map("n", "<Leader>e", ":NvimTreeToggle<CR>", opts)
