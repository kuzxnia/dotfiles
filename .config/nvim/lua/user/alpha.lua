local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
[[                                                                                                           ]],
[[    __                              _                  __               __                          _      ]],
[[   / /_  ____ __   _____     ____  (_)_______     ____/ /___ ___  __   / /____  ______  _  ______  (_)___ _]],
[[  / __ \/ __ `/ | / / _ \   / __ \/ / ___/ _ \   / __  / __ `/ / / /  / //_/ / / /_  / | |/_/ __ \/ / __ `/]],
[[ / / / / /_/ /| |/ /  __/  / / / / / /__/  __/  / /_/ / /_/ / /_/ /  / ,< / /_/ / / /__>  </ / / / / /_/ / ]],
[[/_/ /_/\__,_/ |___/\___/  /_/ /_/_/\___/\___/   \__,_/\__,_/\__, /  /_/|_|\__,_/ /___/_/|_/_/ /_/_/\__,_/  ]],
[[                                                           /____/                                            ]],
}
dashboard.section.buttons.val = {
	dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
	dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
	dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
	dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
	dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
	dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
}

local function footer()
-- NOTE: requires the fortune-mod package to work
	-- local handle = io.popen("fortune")
	-- local fortune = handle:read("*a")
	-- handle:close()
	-- return fortune
	return "kacper.kuzniarski@gmail.com"
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
-- vim.cmd([[autocmd User AlphaReady echo 'ready']])
alpha.setup(dashboard.opts)
