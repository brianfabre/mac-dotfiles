local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

local header = require("alpha.themes.theta").config.layout[2]
local recent = require("alpha.themes.theta").config.layout[4]
-- local recent = require("alpha.themes.startify").config.layout[6]
local dashboard = require("alpha.themes.dashboard")
local links = {
	type = "group",
	val = {
		{ type = "text", val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
		{ type = "padding", val = 1 },
		dashboard.button("e", " " .. " New file", ":ene <BAR> startinsert <CR>"),
		dashboard.button("i", " " .. " Config", ":e $MYVIMRC <CR>"),
		dashboard.button("w", " " .. " Wiki", ":e ~/Documents/wiki/index.md <CR>"),
		dashboard.button("r", " " .. " R", ":cd ~/Documents/R<CR> :Telescope find_files <CR>"),
		dashboard.button("p", " " .. " Python", ":cd ~/Documents/PycharmProjects<CR> :Telescope find_files <CR>"),
		dashboard.button("l", " " .. " Latex", ":cd ~/Documents/Latex<CR> :Telescope find_files <CR>"),
		dashboard.button("s", " " .. " Stata", ":cd ~/Documents/Stata<CR> :Telescope find_files <CR>"),
		dashboard.button("q", " " .. " Quit", ":qa<CR>"),
	},
	position = "center",
}

local config = {
	layout = {
		{ type = "padding", val = 2 },
		header,
		{ type = "padding", val = 2 },
		links,
		{ type = "padding", val = 2 },
		recent,
	},
	opts = {
		noautocmd = false,
		redraw_on_resize = true,
	},
}

alpha.setup(config)
