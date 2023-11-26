local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- General
config.native_macos_fullscreen_mode = true
config.color_scheme = 'Macintosh (base16)'

-- Background color
config.window_background_opacity = 0.90

-- Window
config.initial_rows = 50
config.initial_cols = 150

-- Font 
config.font = wezterm.font("SF Mono", {weight="Light", stretch="Normal", style="Normal"})
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
