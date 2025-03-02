-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Catppuccin Mocha"

-- Fonts
config.font = wezterm.font_with_fallback({
	{
		family = "JetBrains Mono",
		weight = "Bold",
		harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
	},
	{
		family = "Noto Sans JP",
		weight = "Medium",
	},
})
config.font_size = 17
config.line_height = 1.2
config.cell_width = 1

-- Ohters
config.exit_behavior = "Close"

-- Appearance
config.enable_tab_bar = false

-- and finally, return the configuration to wezterm
return config
