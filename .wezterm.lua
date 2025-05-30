local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- General
config.native_macos_fullscreen_mode = true
config.color_scheme = 'ayu'

-- Background color
config.window_background_opacity = 0.90

-- Window
config.initial_rows = 50
config.initial_cols = 150
config.enable_scroll_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

-- Font 
config.font = wezterm.font_with_fallback ({
  { family = "SF Mono", weight = "Light", style = "Normal" },
  { family = "Osaka" },
  { family = "Apple Color Emoji", weight = "Regular" },
  { family = "Apple Symbols" }
})
config.font_size = 12
config.line_height = 1.2

-- Shortcut keys
config.keys = {
  -- Full screen
  {
    key = 'f',
    mods = 'CMD|CTRL',
    action = wezterm.action.ToggleFullScreen,
  },
}

return config
