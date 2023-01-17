local function alert(body)
	require("notify")(body, "info", { title = "Test" })
end

local asdf = vim.g.my_var_name("zettel#vimwiki#initialize_wiki_number")

alert(asdf)
