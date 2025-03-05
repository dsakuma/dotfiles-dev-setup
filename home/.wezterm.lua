local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = 'OneDark (base16)'
config.font = wezterm.font 'MesloLGS Nerd Font Mono'

return config
