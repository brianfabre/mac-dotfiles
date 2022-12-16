local dracula = require("dracula")
dracula.setup({
  -- customize dracula color palette
  colors = {
    bg = "#282A36",
    fg = "#F8F8F2",
    selection = "#44475A",
    comment = "#6272A4",
    red = "#FF5555",
    orange = "#FFB86C",
    yellow = "#F1FA8C",
    green = "#50fa7b",
    purple = "#BD93F9",
    cyan = "#8BE9FD",
    pink = "#FF79C6",
    bright_red = "#FF6E6E",
    bright_green = "#69FF94",
    bright_yellow = "#FFFFA5",
    bright_blue = "#D6ACFF",
    bright_magenta = "#FF92DF",
    bright_cyan = "#A4FFFF",
    bright_white = "#FFFFFF",
    menu = "#21222C",
    visual = "#3E4452",
    gutter_fg = "#4B5263",
    nontext = "#3B4048",
  },
  overrides = {
    -- Examples
    -- NonText = { fg = dracula.colors().white }, -- set NonText fg to white
    -- NvimTreeIndentMarker = { link = "NonText" }, -- link to NonText highlight
    -- Nothing = {} -- clear highlight of Nothing
    htmlH1 = { fg = dracula.colors().cyan, underline = true, bold = true },
    htmlH2 = { fg = dracula.colors().pink, underline = true, bold = true },
    htmlH3 = { fg = dracula.colors().green, underline = true, bold = true },
    htmlH4 = { fg = dracula.colors().orange, underline = true, bold = true },
    htmlH5 = { fg = dracula.colors().purple, underline = true, bold = true },
    htmlH6 = { fg = dracula.colors().yellow, underline = true, bold = true },
    htmlItalic = { fg = dracula.colors().purple, italic = true, },
    htmlLink = { fg = dracula.colors().orange, underline = true, },
    htmlBoldItalic = { fg = dracula.colors().green, bold = true, italic = true },
    ['@string.regex'] = { fg = dracula.colors().bright_white, },

  },
})
