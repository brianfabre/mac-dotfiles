local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

local function return_todo()
	local path = "/Users/brian/Documents/wiki/index.md"
	-- todo's are between begstring and finstring
	local begstring = "important dates"
	local finstring = "wip"
	local todos = {}
	local start = false
	for line in io.lines(path) do
		-- local endmatch = string.find(line, finstring)
		-- local startmatch = string.find(line, begstring)
		local endmatch = line:find(finstring)
		local startmatch = line:find(begstring)
		if endmatch then
			break
		end
		if start then
			-- %] = the last instance of ]
			-- (.*) = match and capture 0+ characters
			local str = line:match("%](.*)")

			-- removes trailing spaces in beg + end
			str = string.gsub(str, "^%s*(.-)%s*$", "%1")

			-- adds string to position 1
			-- str = str:gsub("()", { [1] = " " })
			str = str:gsub("()", { [1] = " " })

			todos[#todos + 1] = str
		end
		if startmatch then
			start = true
		end
	end
	return todos
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
		-- dashboard.button("r", " " .. " R", ":cd ~/Documents/R<CR> :Telescope find_files <CR>"),
		-- dashboard.button("p", " " .. " Python", ":cd ~/Documents/PycharmProjects<CR> :Telescope find_files <CR>"),
		-- dashboard.button("l", " " .. " Latex", ":cd ~/Documents/Latex<CR> :Telescope find_files <CR>"),
		-- dashboard.button("s", " " .. " Stata", ":cd ~/Documents/Stata<CR> :Telescope find_files <CR>"),
		dashboard.button("q", " " .. " Quit", ":qa<CR>"),
	},
	position = "center",
}

-- local fortune = require("alpha.fortune")
local todos = return_todo

local subheader = {
	type = "group",
	-- val = fortune(),
	val = {
		{ type = "text", val = "TO-DO", opts = { hl = "SpecialComment", position = "center" } },
		{ type = "padding", val = 1 },
		{ type = "text", val = os.date("%a, %B %d"), opts = { hl = "Float", position = "center" } },
		{ type = "text", val = todos, opts = { hl = "Normal", position = "center" } },
	},
	opts = {
		position = "center",
	},
}

-- local todo = {
-- 	hi = "asdf",
-- 	bye = "qwerty",
-- }

local config = {
	layout = {
		{ type = "padding", val = 2 },
		header,
		{ type = "padding", val = 2 },
		subheader,
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
