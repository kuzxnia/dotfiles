local wk = require("which-key")

wk.register({
  ["<leader>"] = {
    f = {
      name = "Find in files",
      -- d = { "<cmd>Telescope find_files<cr>", "Find file in directory" },
      g = { "<cmd>lua telescope_live_grep_git()<CR>", "Search in files git" },
      G = { "<cmd>Telescope live_grep<cr>", "Search in files" },
      e = { "<cmd>lua telescope_live_grep_in_path('venv')<CR>", "Search in files in virtual enviroment" },
      b = { "<cmd>Telescope file_browser<cr>", "File browser" },
      B = { "<cmd>Telescope git_branches<cr>", "Find branches" },
    },
    l = {
      name = "LSP",
      f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format file" },
    },
    ["<space>"] = { "<cmd>lua telescope_files_or_git_files()<CR>", "Find file git" },
    ["<C-space>"] = { "<cmd>Telescope find_files<CR>", "Find file" },
    ["*"] = { ":%s/<C-r><C-w>//<Left>", "Find and replace word under cursor"},
    ["w"] = { "<cmd>w!<CR>", "Save" },
    ["q"] = { "<cmd>q!<CR>", "Quit" },
    g = {
      name = "Git",
      j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
      k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
      l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
      p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
      r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
      R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
      s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
      u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
      o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
      b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
      c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
      C = { "<cmd>Telescope git_bcommits<cr>", "Checkout commit(for current file)" },
      d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Git Diff" },
    },
    d = {
      name = "Debugger",
      c = { "<cmd>lua require 'dap'.continue()<CR>", "Continue/Start session"},
      b = { "<cmd>lua require 'dap'.toggle_breakpoint()<CR>", "Toggle breakpoint" },
      q = { "<cmd>lua require 'dap'.disconnect({ terminateDebuggee = true }); require 'dap'.close(); require 'dapui'.close()<CR>", "Disconnect" },
      r = { "<cmd>lua require 'dap'.disconnect({ terminateDebuggee = true }); require 'dap'.close(); require 'dapui'.close(); require 'dap'.continue()<CR>", "Reconnect" },
      o = { "<cmd>lua require 'dap'.step_out()<CR>", "Step out" },
      i = { "<cmd>lua require 'dap'.step_into()<CR>", "Step into" },
      v = { "<cmd>lua require 'dap'.step_over()<CR>", "Step over" },
      u = { "<cmd>lua require 'dap'.up()<CR>", "Up" },
      d = { "<cmd>lua require 'dap'.down()<CR>", "Down" },
      l = {
        name = "+Lists",
        b = { "<cmd>Telescope dap list_breakpoints<CR>", "Breakpoints list" },
        c = { "<cmd>Telescope dap commands<CR>", "Commands List" },
      },
      t = { "<cmd>lua require 'dapui'.toggle()<CR>", "Toggle UI"},
    },
    s = {
      name = "Search",
      c = { "<cmd>nohlsearch<CR>", "Clear search highlight" },
    },
    m = {
      name = "Markdown",
      p = { "<cmd>MarkdownPreview<CR>", "Preview"},
      s = { "<cmd>MarkdownPreviewStop<CR>", "Preview stop"},
      t = { "<cmd>MarkdownPreviewToggle<CR>", "Preview toggle"},
    },
    t = {
        name = "Tools",
        f = {
            name = "Flutter",
            r = {"<cmd>FlutterRun<CR>", "Flutter run"},
            ['<space>'] = {"<cmd>FlutterReload<CR>", "Flutter reload"},
            ['<C-space>'] = {"<cmd>FlutterRestart<CR>", "Flutter restart"},
            q = {"<cmd>FlutterQuit<CR>", "Flutter quit"},
            d = {"<cmd>FlutterDevices<CR>", "Flutter devices"},
            e = {"<cmd>FlutterEmulators<CR>", "Flutter emulators"},
            o = {"<cmd>FlutterOutlineToggle<CR>", "Toggle outline window"},
        }

    }
  },
})
