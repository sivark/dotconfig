-- WezTerm
-- https://wezfurlong.org/wezterm/

local wezterm = require 'wezterm'

return {
  -- Default shell
  default_prog = {"/usr/bin/fish", "--login"},

  -- Smart tab bar [distraction-free mode]
  hide_tab_bar_if_only_one_tab = true,

  -- Color scheme
  -- https://wezfurlong.org/wezterm/config/appearance.html
  -- color_scheme = 'Belafonte Night',
  -- color_scheme = 'Embers (light) (terminal.sexy)',
  color_scheme = 'Kanagawa (Gogh)',

  window_background_opacity = 0.9,

  -- Font configuration
  -- https://wezfurlong.org/wezterm/config/fonts.html
  font = wezterm.font('Fantasque Sans Mono'),
  font_size = 13.0,
  adjust_window_size_when_changing_font_size = false,

  -- Disable ligatures
  -- https://wezfurlong.org/wezterm/config/font-shaping.html
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },

  -- Cursor style
  default_cursor_style = 'BlinkingBar',

  -- Enable CSI u mode
  -- https://wezfurlong.org/wezterm/config/lua/config/enable_csi_u_key_encoding.html
  enable_csi_u_key_encoding = true,


  window_padding = {
    left = "2cell",
    right = "2cell",
    top = "1cell",
    bottom = "1cell",
  },

}
