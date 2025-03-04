local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = 'One Dark (Gogh)'
if wezterm.target_triple == 'x86_64-unknown-linux-gnu' then
  config.font = wezterm.font 'MesloLGS Nerd Font Mono'
end

return config
