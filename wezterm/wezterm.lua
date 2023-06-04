-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- This is where you actually apply your config choices
config.font_size = 16
config.font = wezterm.font_with_fallback({
    -- "JetBrains Mono",
    "SF Mono",
    -- "IBM Plex Mono",
    { family = "Symbols Nerd Font Mono", scale = 0.75 },
})
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true

-- For example, changing the color scheme:
config.color_scheme = "Batman"

-- and finally, return the configuration to wezterm
return config