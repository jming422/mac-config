-- started from https://alexplescan.com/posts/2024/08/10/wezterm/
-- We almost always start by importing the wezterm module
local wezterm = require 'wezterm'
-- Define a lua table to hold _our_ module's functions
local module = {}

-- Returns a bool based on whether the host operating system's
-- appearance is light or dark.
function module.is_dark()
  -- wezterm.gui is not always available, depending on what
  -- environment wezterm is operating in. Just return true
  -- if it's not defined.
  if wezterm.gui then
    -- Some systems report appearance like 'Dark High Contrast'
    -- so let's just look for the string 'Dark' and if we find
    -- it assume appearance is dark.
    return wezterm.gui.get_appearance():find('Dark')
  end
  return true
end

-- Sets my Helix theme to dark mode
function module.set_helix_dark()
  local link = wezterm.home_dir .. '/.config/helix/themes/auto_dark_mode.toml'
  os.remove(link)
  wezterm.run_child_process {'ln', '-s', '/opt/homebrew/opt/helix/libexec/runtime/themes/everforest_dark.toml', link}
  wezterm.run_child_process {'pkill', '-USR1', 'hx'}
end

-- Sets my Helix theme to light mode
function module.set_helix_light()
  local link = wezterm.home_dir .. '/.config/helix/themes/auto_dark_mode.toml'
  os.remove(link)
  wezterm.run_child_process {'ln', '-s', '/opt/homebrew/opt/helix/libexec/runtime/themes/everforest_light.toml', link}
  wezterm.run_child_process {'pkill', '-USR1', 'hx'}
end

module.dark_colors = {
  fg = '#d3c6aa',
  fg_dim = '#9da9a0',
  bg1 = '#343f44',
  bg2 = '#3d484d',
  bg3 = '#475258',
  bg4 = '#4f585e',
  bg5 = '#56635f'
}

module.light_colors = {
  fg = '#5c6a72',
  fg_dim = '#708089',
  bg1 = '#f4f0d9',
  bg2 = '#efebd4',
  bg3 = '#e6e2cc',
  bg4 = '#e0dcc7',
  bg5 = '#bdc3af'
}

return module
