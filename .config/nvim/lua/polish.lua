-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set the scrolloff to 5
vim.opt.scrolloff = 5

-- Improve navigation between panes in vim
vim.keymap.set("n", "<c-h>", ":TmuxNavigateLeft<CR>")
vim.keymap.set("n", "<c-j>", ":TmuxNavigateDown<CR>")
vim.keymap.set("n", "<c-k>", ":TmuxNavigateUp<CR>")
vim.keymap.set("n", "<c-l>", ":TmuxNavigateRight<CR>")

-- buffers
vim.keymap.set("n", "Q", function() require("astrocore.buffer").close() end, { desc = "Close buffer" })
vim.keymap.set("n", "L", function() require("astrocore.buffer").nav(vim.v.count1) end, { desc = "Next buffer" })
vim.keymap.set("n", "H", function() require("astrocore.buffer").nav(-vim.v.count1) end, { desc = "Previous buffer" })

-- comments
vim.keymap.set("n", "<Leader>c", "gcc", { desc = "Toggle comment line", remap = true })
vim.keymap.set("x", "<Leader>c", "gc", { desc = "Toggle comment", remap = true })

-- fix coursor move to left after insert mode exit
vim.keymap.set("i", "<esc>", "<esc>`^")

-- telescope quickfix
vim.keymap.set(
  "n",
  "<Leader><space>",
  function() require("telescope.builtin").find_files() end,
  { desc = "Find files" }
)
