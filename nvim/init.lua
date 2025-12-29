-- Thanks to https://lachlanarthur.github.io/Braille-ASCII-Art/ for the ASCII Braille art
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.number = true
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.updatetime = 250
vim.opt.scrolloff = 8
vim.opt.clipboard = "unnamedplus"
vim.opt.signcolumn = "yes:1"
vim.opt.statuscolumn = "%=%l │ "
vim.opt.laststatus = 3
vim.opt.cmdheight = 0

vim.opt.numberwidth = 3

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldcolumn = "1"
vim.opt.foldenable = false
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

-- make the cursor a vertical bar in all modes
-- vim.opt.guicursor = "a:ver25"

vim.opt.fillchars = {
	fold = " ",
	foldopen = "",
	foldclose = "",
	foldsep = " ",
	eob = " ",
}

vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		vim.opt_local.foldmethod = "expr"
		vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
	end,
})

vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
		source = "if_many",
	},
	float = {
		source = "if_many",
		border = "rounded",
	},
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic in float" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
vim.keymap.set("n", "<leader>rl", function()
	vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { desc = "Toggle relative line numbers" })
vim.keymap.set("n", "<leader>w", function()
	vim.opt.wrap = not vim.opt.wrap:get()
end, { desc = "Toggle line wrapping" })

vim.keymap.set("n", "<leader>s", function()
	if vim.o.laststatus == 0 then
		vim.o.laststatus = 3
	else
		vim.o.laststatus = 0
	end
end, { desc = "Toggle Statusline" })

require("lazy").setup({
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			require("gruvbox").setup({
				contrast = "hard",
			})
			vim.cmd.colorscheme("gruvbox")

			vim.api.nvim_set_hl(0, "LineNr", { bg = "#121414", fg = "#7c6f64" })
			vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "#121414", fg = "#b35e09", bold = true })
			vim.api.nvim_set_hl(0, "SignColumn", { bg = "#121414", bold = true })
			vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#b35e09", bold = true })
			vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#3c3836", bold = true })
		end,
	},
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = {
			dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
			options = { "buffers", "curdir", "tabpages", "winsize" },
		},
	},
	{
		"nvimdev/dashboard-nvim",
		lazy = false,
		opts = function()
			local logo = [[
                ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⡕⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡎⠙⠇⠧⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                ⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⢠⠤⠁⢸⡄⠀⠉⣇⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠇⣆⡐⠊⢠⣨⣺⠔⣀⡤⢾⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⢤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                ⠀⠀⠀⠀⠀⠀⠀⠀⢠⡨⠇⠀⠀⢀⢸⣇⠀⣉⠀⠈⠾⡆⠀⠀⠀⠀⠀⡠⡄⠀⠀⠀⠀⠀⠀⠀⠀⢠⣀⠚⠈⠰⠸⢥⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                ⠀⠀⠀⠀⠀⠀⠀⠀⢸⡉⠀⠀⠠⢤⣾⣗⠅⠐⠒⠂⠈⢳⡄⠀⠀⠀⡔⠁⣷⡀⠀⠀⠀⠀⠀⠀⢀⠾⡈⠀⣀⠇⠀⢚⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                ⠀⠀⠀⠀⠀⠀⠀⠀⡈⣽⣅⠀⠀⢝⣿⣯⠓⠂⠀⠠⢀⣀⣈⣶⣤⣸⠀⢀⢿⠀⠀⠀⠀⢀⡔⠊⠀⠀⠛⠀⣿⢏⣡⡤⢽⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                ⠀⠀⠀⠀⠀⠀⠀⠀⡇⣚⣷⣟⠉⢹⠏⠀⣳⣦⣬⣲⣶⣿⣿⣏⡑⢝⠀⠨⠧⠤⡄⠠⢯⣀⠀⠈⠢⡀⡀⢦⡏⠈⠁⠀⢉⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                ⠀⠀⠀⠀⠀⠀⠀⡰⢺⡔⢯⣷⡦⡌⣤⣬⢿⣿⣿⠻⡖⠯⣿⣻⣿⠈⡸⢀⣴⣶⣼⢄⣸⣢⠀⠈⠢⡐⣡⡼⢀⡠⢤⣐⠀⢹⡀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀
                ⠀⠀⠀⠀⠀⠀⠀⢹⡿⡷⣾⡿⡱⠡⡻⣿⢿⣿⡿⢋⢳⣿⣿⣟⣯⠥⣥⣹⣿⣻⡶⢮⣸⣿⡶⢄⠀⢱⣿⡫⠕⡐⡂⠐⠁⠊⠒⡆⠀⠀⠔⣼⠀⠀⠀⠀⠀⠀⠀⠀
                ⠀⠀⠀⠀⠀⠀⠠⡚⣢⠓⠈⠒⣁⣄⠈⠂⠭⠥⠕⠋⠑⠍⢫⡋⠧⠚⠡⠻⣿⣿⡷⢺⣧⣿⣽⣤⣨⢹⠟⠉⠁⣀⣠⠰⠒⠉⠉⠁⢀⠎⠀⣹⠀⠀⠀⠀⠀⢀⡴⡟
                ⠀⠀⠀⠀⠀⠀⢠⢉⡠⡳⠕⠮⢐⠪⠕⠢⠦⢔⣐⠴⣦⣄⣀⣀⠤⣦⡀⠁⠒⠐⠒⢎⠺⣟⣮⠿⢃⣾⣻⣗⣦⣾⡿⣢⢀⣠⡂⠑⠞⠀⣠⡟⠀⠀⠀⢀⣼⢾⡵⠀
                ⠀⠀⠀⠀⠀⠀⣮⢋⠰⠶⠶⠆⣓⠁⠪⠆⠰⠶⠀⠙⢀⢩⢀⣀⢭⡇⣋⠒⠐⠒⢱⢄⠈⠒⠒⠈⡁⠹⠘⣜⢿⣵⣏⣱⢚⣮⣽⡆⠀⢈⣿⡁⠀⠀⢠⣫⠫⣴⠃⠀
                ⠀⠀⠀⠀⠀⡘⢀⣠⡴⣖⣒⡺⠮⢿⡒⠲⣶⡒⠛⣛⣶⣤⠤⢅⢀⣂⡘⠐⠒⠈⠃⣑⡉⢥⡬⠍⡽⡄⠑⠠⢁⠢⠭⣸⠽⣯⣏⡧⣾⣾⢴⡿⠀⢠⢃⢯⣼⠇⠀⠀
                ⠀⠀⠀⡠⠔⠞⡿⢫⢪⠂⣱⠎⣱⠄⠈⡢⠀⠉⠉⣠⠤⠐⠒⠒⠒⢒⣒⡒⠾⣿⠦⣌⣁⣑⠣⡟⢈⢊⢖⡠⠤⠤⡄⠑⣷⠿⢯⡛⣷⡿⣲⣩⡭⡙⢜⢗⡏⠀⠀⠀
                ⠀⢠⠮⡤⢀⡀⠉⠲⣕⡮⠕⢋⡠⠒⢁⡠⠴⠒⠄⠙⠳⣤⡈⠫⣓⢖⠒⢪⡢⡀⠑⢌⠙⢟⠛⠶⢤⣁⠊⠅⣜⠗⡽⣴⢪⢟⢽⣯⣿⠀⣻⣾⡿⣝⢑⣿⠁⠀⠀⠀
                ⣰⡿⢸⠡⡏⣰⣵⣶⡿⠿⠮⠿⠾⠾⠷⠦⢤⡤⡀⣀⣠⣄⡙⢢⣈⠂⠍⠛⠒⠚⢀⠨⠇⠀⠑⠒⠉⠉⣙⣒⣺⣄⡙⠐⢛⣭⣷⡈⠓⢿⣿⡏⠄⣧⣽⡃⠀⠀⠀⠀
                ⡷⣸⢐⣸⣿⡻⠩⣒⡐⢈⡍⠉⠉⠁⠁⠈⠀⠈⠀⠀⠉⠈⠉⠙⠛⢶⣴⣶⣖⣊⣁⣀⡤⠔⢄⠀⢟⠉⢩⠤⠬⣩⡙⢫⣉⢛⢿⣭⠶⣖⢮⡿⣶⢿⣽⠀⠀⠀⠀⠀
                ⢺⣻⣤⣿⠇⠀⠀⠀⠙⢿⠆⠀⠀⠀⢰⣥⣶⣶⣤⣦⣦⣄⣄⡀⠀⠀⠱⡇⠉⠋⠛⠟⠷⣖⣬⣦⡀⢱⡄⠩⡭⡭⢣⠈⢟⠅⡯⣙⣽⣿⡷⣽⣾⢷⠇⠀⠀⠀⠀⠀
                ⠀⠙⢿⠏⠀⠀⡀⠠⣀⠀⠓⡄⠀⠀⠁⢻⡿⣿⣿⣿⣿⣿⣻⣿⣷⣄⠀⢿⠀⠀⠂⠀⠀⠈⠒⠩⢛⢻⢽⣆⣉⢉⢉⡠⠼⠀⠑⠉⠘⣿⣿⢯⣯⣾⠀⠀⠀⠀⠀⠀
                ⠀⢀⠊⢠⣰⣶⣿⣿⢿⣦⠀⠇⠀⠒⡀⠀⣻⢻⣿⣷⡿⣾⣾⣿⣿⣿⣆⠹⣄⠀⠴⣖⠂⠐⠁⠊⠐⠀⢑⡡⢝⠧⣄⣤⠴⠴⡄⠸⡉⢤⣝⢝⢗⡇⠀⠀⠀⠀⠀⠀
                ⠀⢸⢀⣿⢟⡿⣿⢿⣻⠋⠀⡀⠀⠀⣯⣚⣏⣞⡿⡵⡽⣟⣿⢿⣿⣿⡇⠀⠹⣷⠧⣫⠀⠀⠀⠀⠠⠂⠀⠀⠀⠈⠊⠝⡶⣦⣸⠀⢣⢸⣿⡆⡿⣅⠀⠀⠀⠀⠀⠀
                ⠀⠘⡴⢿⢽⢹⣿⡞⣿⣇⠠⠁⠀⠀⠑⢷⣎⣺⣱⢿⣻⣟⣯⣿⣯⣿⡇⠀⣤⡇⣺⡗⡇⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⢝⢿⣼⣼⠿⣿⢹⢽⡆⠀⠀⠀⠀⠀
                ⠀⠀⢨⠘⢮⣽⣿⠿⣿⣿⣷⠀⠐⡄⠀⠀⠋⠿⣿⡿⣿⡿⣯⢽⣿⠞⠁⠀⣼⣿⡼⣛⡋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠫⣫⣿⡔⡺⣺⢿⠀⠀⠀⠀⠀
                ⠀⠀⠜⢀⢷⠅⠀⠀⣿⡿⣿⡇⠀⡇⢀⠀⢀⣀⠀⠈⢉⠓⠛⠉⠀⠀⠀⠀⠈⠛⠛⠿⣺⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠙⣿⣿⢾⡱⡍⡇⠀⠀⠀⠀
                ⠀⠰⠁⣘⠋⠀⠀⠀⢻⠙⣿⡇⠀⠀⠀⠐⣠⠿⠃⠀⠀⠉⠹⡖⠀⠀⠀⠀⠀⠀⠀⠀⡀⠑⣤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢨⢿⣿⣹⢎⠃⠀⠀⠀⠀
                ⠀⠈⠀⠸⠀⠀⠀⠀⠼⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠈⡄⠀⠀⠀⣀⣴⠓⠒⢻⣯⡃⡫⠒⠠⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠜⢼⣟⣏⣝⠍⠀⠀⠀⠀⠀
                ⠀⢘⠠⣤⠀⢀⠀⠀⠀⠀⠀⠀⠀⣀⠀⠀⠀⠀⠀⠀⠀⢀⡀⠀⠑⠀⣀⡼⣿⡻⣝⢿⣚⣯⢵⣞⣆⢀⣤⣤⡄⠀⠐⠠⢄⢀⣀⠄⢞⣜⡹⣇⣿⠋⠀⠀⠀⠀⠀⠀
                ⠀⠈⠒⠛⢧⠎⠀⠀⠀⠀⠀⠀⠈⡟⠆⠀⠀⠀⠀⢀⠎⠉⢱⣢⣤⡾⠻⢿⣟⠿⠉⠀⡼⢀⠙⠙⣟⣼⠟⠖⡟⠀⠀⡄⠀⡁⠀⢁⣇⡓⣧⣿⡝⠀⠀⠀⠀⠀⠀⠀
                ⠀⠀⠀⢀⢎⢽⢰⠃⢸⠂⢰⠆⠀⡀⠀⠀⠀⠀⠀⡈⠀⠀⢠⡿⠀⢀⠀⢢⠀⠀⢀⣼⠳⣪⣎⡳⠊⢸⠄⠀⠂⠀⠀⡇⢀⠑⡷⣫⢞⣷⣯⠟⠀⠀⠀⠀⠀⠀⠀⠀
                ⠀⠀⠀⡎⣰⣤⣾⢴⣼⣤⣾⣀⣸⠃⡴⠤⢦⠀⣄⠧⢴⢶⣿⣾⠀⠈⡆⠀⠃⠀⢰⣝⣾⡿⡗⡿⠈⡉⠀⣀⣴⣀⣴⢯⠝⣨⡧⣟⣾⣏⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀
                ⠀⠀⢰⢹⠸⠁⠇⡌⢰⠁⣟⠉⢻⠚⠷⡦⠿⣤⣽⣤⣼⢿⣿⡿⠀⡀⠘⠀⠀⠀⣽⣺⣫⣪⣮⢷⣄⣦⣯⣾⣿⡝⢇⢢⢼⣿⣽⣾⡿⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                ⠀⠀⢸⠀⠄⠀⡄⢂⠨⢄⡉⠈⡉⠀⠘⠃⠀⣿⠁⠴⠿⠞⢫⠃⠀⡆⠀⠀⢠⢰⢿⣵⣭⠧⢅⣻⠻⡛⢗⣿⢿⣽⣿⣺⣿⣻⣾⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                ⠀⠀⠀⡇⠁⠀⠋⠘⠀⢰⠃⠀⠃⠀⠈⠀⠀⠀⠀⠀⠀⠔⠁⠀⣼⠀⠀⠰⠉⢰⣿⣿⣪⣿⣛⣶⣿⣯⡻⣷⣻⣟⣿⢟⡻⢟⢁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                ⠀⠀⢰⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣄⠿⠀⠀⠀⢠⣾⣫⣷⣿⣿⣿⣿⣿⣯⡿⠯⠟⠛⠛⠛⠚⠒⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                ⠀⠀⢸⠀⠀⢀⡀⣀⠀⣀⠀⢀⣀⣀⣀⠴⠤⠦⠄⢄⣄⢂⣬⣀⣀⣀⣠⡴⣟⢝⠯⣛⠭⣯⡽⢋⠐⠀⠀⠂⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                ⠀⠀⡆⣐⣶⡷⣿⣾⣿⣶⡶⣶⣶⣾⣷⠿⠿⣽⣿⣿⣟⣿⣭⣿⣿⢿⣿⣽⣭⢵⣫⣼⡙⠐⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                ⠀⠀⠈⠉⠛⠛⠫⢽⢿⣞⣔⣿⡿⠋⠃⠁⠈⠐⠙⠩⠻⠓⠏⠛⠱⠉⠍⠍⠁⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
            ]]
			local skull = [[
              ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⠤⣠⣄⣲⠒⡤⠀⢠⠄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
              ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣄⡆⣎⢧⢓⠥⠁⠊⠀⠄⠀⠀⠈⠁⠀⠠⠨⠂⢄⠄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
              ⠀⠀⠀⠀⠀⠀⠀⢀⡴⣾⣿⢣⣿⣝⣅⠒⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⡠⠚⠑⡳⢦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
              ⠀⠀⠀⠀⠀⢀⣴⣟⢟⣿⣿⣭⢯⡠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡔⣢⡁⡎⡏⡓⣢⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀
              ⠀⠀⠀⢀⣆⣿⣫⣿⣿⣗⣿⢯⣈⠶⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠑⡜⠂⢱⡡⣳⢃⡞⣦⡀⠀⠀⠀⠀⠀⠀⠀
              ⠀⠀⣰⣻⣿⣽⣾⣿⢼⡯⣛⢵⠤⠐⠄⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⣀⠄⠊⢝⢄⠣⢑⡹⣷⢃⡀⠀⠀⠀⠀⠀
              ⠀⢰⣻⣷⣿⣿⡗⣿⣿⣝⣮⢿⣭⠒⠒⠠⠅⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠐⠋⡠⢀⠕⢽⣌⢨⢑⢟⢎⡟⣔⡄⠀⠀⠀⠀
              ⠀⣿⣽⡿⣿⡽⣯⡿⢯⣛⢵⡽⣲⡈⠿⠯⡌⣒⠒⠚⠁⠀⠂⠀⠄⠀⠀⠀⠀⢠⠊⡐⡀⡀⡱⡗⠐⣌⢲⢵⢿⠷⡫⡀⠀⠀⠀
              ⠀⣿⣷⣿⡿⣿⣷⡷⣤⣤⠸⢲⠳⡻⡾⢞⢝⠀⠌⠁⠀⠀⠀⠀⢠⠀⠀⠓⠂⠀⠁⠀⠈⠀⣌⡖⡄⡰⢋⡾⡾⢾⣽⡇⠀⠀⠀
              ⠀⢽⣟⣿⢿⢟⣽⣿⡞⣷⡿⣽⣶⣷⢟⡷⣣⣠⣤⣰⣤⡄⣀⠀⠀⠀⠓⠀⠀⡴⣐⢌⡐⢼⢆⢢⣰⢗⣶⠯⡽⢛⣯⠄⠀⠀⠀
              ⠀⣿⣾⣿⣿⣿⣿⣿⣿⣿⣻⡯⢻⠻⣵⣻⣽⢲⣿⣿⣿⣿⣷⣷⣷⣦⡀⠐⠰⡮⢫⣰⣷⡾⡁⠍⡰⢏⡾⣻⡽⣽⣾⠀⠀⠀⠀
              ⠀⣿⣻⢿⣽⣿⡿⣿⣿⣿⣿⣿⠀⢀⡌⢿⠞⡛⣻⣿⡿⣿⣿⣿⣿⣿⣷⠠⢀⣻⣿⢿⣞⡟⣏⣸⢵⣕⣽⣮⢪⢷⣿⠀⠀⠀⠀
              ⠀⣿⣼⠳⣩⣟⢻⣵⣿⣿⣿⢁⠁⠢⢆⠊⠜⣶⢉⠽⣻⠚⡿⣿⣿⣿⣿⡇⢉⡹⣟⣻⣛⡴⣗⣞⣟⣷⣫⢿⣟⡟⡏⠀⠀⠀⠀
              ⢀⣿⣼⣛⣽⣿⣿⣿⣟⣿⠲⣿⣿⡠⢌⠈⠡⠘⡳⢂⠐⠴⣌⣼⣿⣾⣿⡇⢀⠄⡸⣿⣮⣽⣽⣻⣾⠷⢿⣙⣿⡞⠀⠀⠀⠀⠀
              ⢸⣿⣾⣆⣿⣿⢕⣷⣿⡇⣔⢻⣿⢿⣄⠈⠀⠀⣀⢒⣈⣖⠷⢿⣿⡿⠟⠁⠈⠀⢿⠿⠷⠏⠟⠚⠶⡿⡿⢟⢵⡇⠀⠀⠀⠀⠀
              ⠀⠳⣿⣿⣯⣽⣻⣾⣿⡇⣾⣾⡿⣯⣿⡆⠈⠉⡰⣓⣻⡼⣻⣶⡒⠂⠄⠀⠂⢂⠀⠤⢘⣈⣉⡐⢀⢀⣘⡽⡋⠀⠀⠀⠀⠀⠀
              ⠀⠀⠛⠿⠛⠛⣿⣿⣿⣷⣛⠙⠠⠚⠟⠁⡀⠠⠣⢧⢏⣼⣻⣿⣷⡦⡆⢤⠠⢊⠘⣻⣯⣿⣯⠷⣿⠫⠈⡝⠀⠀⠀⠀⠀⠀⠀
              ⠀⠀⠀⠀⠀⠀⠘⡿⣿⣿⠛⠃⠈⠀⠀⢮⠀⠎⠘⠜⣸⣿⣿⣛⡿⠵⠭⠉⠂⠁⣰⠏⠁⢸⣿⢢⠃⢢⠘⠀⠀⠀⠀⠀⠀⠀⠀
              ⠀⠀⠀⠀⠀⠀⣼⣕⣤⡏⡀⢊⡀⡄⠀⡀⠀⡪⢠⣙⠧⡯⡊⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⠑⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀
              ⠀⠀⠀⠀⠀⠀⠻⠟⠏⠀⠈⠟⠀⡲⡉⢶⠄⡄⢰⠂⢃⠑⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                         ⠁⠒⠑⠄⠚⠂⠚⠂⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
            ]]
			logo = string.rep("\n", 1) .. skull .. ""
			local opts = {
				theme = "doom",
				hide = { statusline = false },
				config = {
					header = vim.split(logo, "\n"),
					footer = {},
					center = {
						{
							desc = " Find File",
							key = "f",
							action = function()
								require("telescope.builtin").find_files()
							end,
						},
						{ desc = " New File", key = "n", action = "ene | startinsert" },
						{
							desc = " Recent Files",
							key = "r",
							action = function()
								require("telescope.builtin").oldfiles()
							end,
						},
						{
							desc = " Find Text",
							key = "g",
							action = function()
								require("telescope.builtin").live_grep()
							end,
						},
						{
							desc = " Restore Session",
							key = "s",
							action = function()
								require("persistence").load()
							end,
						},
						{
							desc = " Quit",
							key = "q",
							action = function()
								vim.cmd("qa")
							end,
						},
					},
				},
			}
			for _, button in ipairs(opts.config.center) do
				button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
				button.key_format = "  %s"
			end
			if vim.o.filetype == "lazy" then
				vim.api.nvim_create_autocmd("WinClosed", {
					pattern = tostring(vim.api.nvim_get_current_win()),
					once = true,
					callback = function()
						vim.schedule(function()
							vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
						end)
					end,
				})
			end
			return opts
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
		cmd = "Neotree",
		keys = {
			{
				"<leader>e",
				function()
					require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
				end,
				desc = "Explorer NeoTree (cwd)",
			},
		},
		deactivate = function()
			vim.cmd([[Neotree close]])
		end,
		init = function()
			if vim.fn.argc(-1) == 1 then
				local stat = vim.loop.fs_stat(vim.fn.argv(0))
				if stat and stat.type == "directory" then
					require("neo-tree")
				end
			end
		end,
		opts = {
			sources = { "filesystem", "buffers", "git_status", "document_symbols" },
			open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
			filesystem = {
				bind_to_cwd = false,
				follow_current_file = { enabled = true },
				use_libuv_file_watcher = true,
			},
			window = { mappings = { ["<space>"] = "none" } },
			default_component_configs = {
				indent = {
					with_expanders = true,
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
				},
			},
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
		enabled = true,
		opts = function()
			local icons = {
				diagnostics = { Error = " ", Warn = " ", Hint = " ", Info = " " },
				git = { added = " ", modified = " ", removed = " " },
			}
			return {
				options = {
					theme = "gruvbox",
					globalstatus = false,
					disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch" },
					lualine_c = {
						{
							"diagnostics",
							symbols = {
								error = icons.diagnostics.Error,
								warn = icons.diagnostics.Warn,
								info = icons.diagnostics.Info,
								hint = icons.diagnostics.Hint,
							},
						},
						{
							"filetype",
							icon_only = true,
							separator = "",
							padding = { left = 1, right = 0 },
						},
						{ "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
					},
					lualine_x = {
						{
							function()
								return require("noice").api.status.command.get()
							end,
							cond = function()
								return package.loaded["noice"] and require("noice").api.status.command.has()
							end,
							color = { fg = "#ff9e64" },
						},
						{
							function()
								return require("noice").api.status.mode.get()
							end,
							cond = function()
								return package.loaded["noice"] and require("noice").api.status.mode.has()
							end,
							color = { fg = "#ff9e64" },
						},
						{ "encoding" },
						{ "fileformat" },
					},
					lualine_y = {
						{ "progress", separator = " ", padding = { left = 1, right = 0 } },
						{ "location", padding = { left = 0, right = 1 } },
					},
					lualine_z = {
						function()
							return " " .. os.date("%R")
						end,
					},
				},
				extensions = { "neo-tree", "lazy" },
			}
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		main = "ibl",
		opts = {
			indent = { char = "│", tab_char = "│" },
			scope = { enabled = false },
			exclude = {
				filetypes = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
			},
		},
	},
	{
		"echasnovski/mini.indentscope",
		version = false,
		event = { "BufReadPost", "BufNewFile" },
		opts = { symbol = "│", options = { try_as_border = true } },
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			routes = {
				{
					filter = {
						event = "msg_show",
						any = { { find = "%d+L, %d+B" }, { find = "; after #%d+" }, { find = "; before #%d+" } },
					},
					view = "mini",
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = false,
			},
		},
	},
	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 3000,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
			on_open = function(win)
				vim.api.nvim_win_set_config(win, { zindex = 100 })
			end,
		},
		config = function(_, opts)
			local notify = require("notify")
			notify.setup(opts)
			vim.notify = notify
		end,
		keys = {
			{
				"<leader>un",
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
				desc = "Dismiss all notifications",
			},
		},
	},
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
		opts = {
			window = {
				backdrop = 0.95,
				width = 120,
				height = 1,
				options = {
					signcolumn = "no",
					number = false,
					relativenumber = false,
					cursorline = false,
					cursorcolumn = false,
					foldcolumn = "0",
					list = false,
				},
			},
			plugins = {
				options = { enabled = true, ruler = false, showcmd = false, laststatus = 0 },
				twilight = { enabled = true },
				gitsigns = { enabled = false },
				tmux = { enabled = false },
				kitty = { enabled = false, font = "+4" },
			},
		},
	},
	{
		"folke/twilight.nvim",
		cmd = "Twilight",
		keys = {
			{ "<leader>ud", "<cmd>Twilight<cr>", desc = "Toggle Dimming" },
		},
		opts = {
			dimming = {
				alpha = 0.25,
				color = { "Normal", "#ffffff" },
				term_bg = "#000000",
				inactive = false,
			},
			context = 10,
			treesitter = true,
			expand = {
				"function",
				"method",
				"table",
				"if_statement",
			},
			exclude = {},
		},
	},
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("oil").setup({ view_options = { show_hidden = true } })
			vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup({
				ensure_installed = {
					"asm",
					"bash",
					"c",
					"html",
					"javascript",
					"json",
					"lua",
					"markdown",
					"markdown_inline",
					"python",
					"query",
					"regex",
					"tsx",
					"typescript",
					"vim",
					"yaml",
				},
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "pyright", "ts_ls" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "mason-org/mason.nvim", "mason-org/mason-lspconfig.nvim" },
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = ev.buf,
						callback = function()
							vim.lsp.buf.format({ async = false })
						end,
					})
				end,
			})
			vim.lsp.config("lua_ls", {
				cmd = { "lua-language-server" },
				filetypes = { "lua" },
				root_markers = {
					".luarc.json",
					".luarc.jsonc",
					".luacheckrc",
					".stylua.toml",
					"stylua.toml",
					"selene.toml",
					"selene.yml",
					".git",
				},
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
			vim.lsp.config("pyright", {
				cmd = { "pyright-langserver", "--stdio" },
				filetypes = { "python" },
				root_markers = {
					"pyproject.toml",
					"setup.py",
					"setup.cfg",
					"requirements.txt",
					"Pipfile",
					"pyrightconfig.json",
					".git",
				},
			})
			vim.lsp.config("ts_ls", {
				cmd = { "typescript-language-server", "--stdio" },
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
				},
				root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
			})
			vim.lsp.enable("lua_ls")
			vim.lsp.enable("pyright")
			vim.lsp.enable("ts_ls")
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason-org/mason.nvim" },
		config = function()
			require("mason-tool-installer").setup({ ensure_installed = { "stylua", "prettier" } })
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
				}),
				sources = cmp.config.sources(
					{ { name = "nvim_lsp" }, { name = "luasnip" } },
					{ { name = "buffer" }, { name = "path" } }
				),
			})
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			require("which-key").setup({ preset = "modern" })
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim", { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local builtin = require("telescope.builtin")
			telescope.setup({
				defaults = {
					mappings = {
						i = {
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
						},
					},
					file_ignore_patterns = { "node_modules/", ".git/" },
					layout_config = { horizontal = { preview_width = 0.55 } },
				},
			})
			telescope.load_extension("fzf")
			telescope.load_extension("notify")
			vim.keymap.set("n", "<leader>ff", function()
				builtin.find_files({ hidden = true, no_ignore = false })
			end, { desc = "Find files" })
			vim.keymap.set("n", "<leader>fa", function()
				builtin.find_files({ hidden = true, no_ignore = true })
			end, { desc = "Find all files" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help tags" })
			vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent files" })
			vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Find word" })
			vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Find diagnostics" })
			vim.keymap.set("n", "<leader>n", function()
				require("telescope").extensions.notify.notify()
			end, { desc = "Notifications" })
		end,
	},
})
