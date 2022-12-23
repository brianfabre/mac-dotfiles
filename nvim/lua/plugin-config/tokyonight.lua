require("tokyonight").setup({
  transparent = true,
  styles = { sidebars = "transparent", floats = "transparent", },
  on_highlights = function(hl, c)
    -- local prompt = "#2d3149"
    -- hl.TelescopeNormal = {
    --   bg = c.bg_dark,
    --   fg = c.fg_dark,
    -- }
    -- hl.TelescopeBorder = {
    --   bg = c.bg_dark,
    --   fg = c.bg_dark,
    -- }
    -- hl.TelescopePromptNormal = {
    --   bg = prompt,
    -- }
    -- hl.TelescopePromptBorder = {
    --   bg = prompt,
    --   fg = prompt,
    -- }
    -- hl.TelescopePromptTitle = {
    --   bg = prompt,
    --   fg = prompt,
    -- }
    -- hl.TelescopePreviewTitle = {
    --   bg = c.bg_dark,
    --   fg = c.bg_dark,
    -- }
    -- hl.TelescopeResultsTitle = {
    --   bg = c.bg_dark,
    --   fg = c.bg_dark,
    -- }

    local colors = {
  bg = "#1a1b26",
  bg_dark = "#16161e",
  bg_float = "#16161e",
  bg_highlight = "#292e42",
  bg_popup = "#16161e",
  bg_search = "#3d59a1",
  bg_sidebar = "#16161e",
  bg_statusline = "#16161e",
  bg_visual = "#33467c",
  black = "#15161e",
  blue = "#7aa2f7",
  blue0 = "#3d59a1",
  blue1 = "#2ac3de",
  blue2 = "#0db9d7",
  blue5 = "#89ddff",
  blue6 = "#b4f9f8",
  blue7 = "#394b70",
  border = "#15161e",
  border_highlight = "#27a1b9",
  comment = "#565f89",
  cyan = "#7dcfff",
  dark3 = "#545c7e",
  dark5 = "#737aa2",
  diff = {
    add = "#20303b",
    change = "#1f2231",
    delete = "#37222c",
    text = "#394b70"
  },
  error = "#db4b4b",
  fg = "#c0caf5",
  fg_dark = "#a9b1d6",
  fg_float = "#a9b1d6",
  fg_gutter = "#3b4261",
  fg_sidebar = "#a9b1d6",
  git = {
    add = "#4097a3",
    change = "#506d9b",
    delete = "#c47981",
    ignore = "#545c7e"
  },
  gitSigns = {
    add = "#399a96",
    change = "#6382bd",
    delete = "#c25d64"
  },
  green = "#9ece6a",
  green1 = "#73daca",
  green2 = "#41a6b5",
  hint = "#1abc9c",
  info = "#0db9d7",
  magenta = "#bb9af7",
  magenta2 = "#ff007c",
  none = "NONE",
  orange = "#ff9e64",
  purple = "#9d7cd8",
  red = "#f7768e",
  red1 = "#db4b4b",
  teal = "#1abc9c",
  terminal_black = "#414868",
  warning = "#e0af68",
  yellow = "#e0af68"
}

    hl.htmlH1 = { fg = c.teal, underline = true, bold = true }
    hl.htmlH2 = { fg = c.blue, underline = true, bold = true }
    hl.htmlH3 = { fg = c.green, underline = true, bold = true }
    hl.htmlBold = { fg = c.red, bold = true }
    hl.htmlItalic = { fg = c.magenta, italic = true, }
    hl.htmlBoldItalic = { fg = c.yellow, bold = true, italic = true }
    hl.htmlLink = { fg = c.orange, underline = true, }
    hl.Comment = { fg = c.dark5 }

  end,
})
