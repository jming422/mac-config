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
  wezterm.run_child_process {'ln', '-s', '/opt/homebrew/opt/helix/libexec/runtime/themes/rose_pine_moon.toml', link}
  wezterm.run_child_process {'pkill', '-USR1', 'hx'}
end

-- Sets my Helix theme to light mode
function module.set_helix_light()
  local link = wezterm.home_dir .. '/.config/helix/themes/auto_dark_mode.toml'
  os.remove(link)
  wezterm.run_child_process {'ln', '-s', '/opt/homebrew/opt/helix/libexec/runtime/themes/rose_pine_dawn.toml', link}
  wezterm.run_child_process {'pkill', '-USR1', 'hx'}
end

-- Rosé Pine Moon
module.dark_colors = {
  fg = '#e0def4',     -- text
  fg_dim = '#c4a7e7', -- subtle
  bg1 = '#232136',    -- base
  bg2 = '#2a273f',    -- surface
  bg3 = '#44415a',    -- highlight med
  bg4 = '#2a283e',    -- highlight low
  bg5 = '#56526e',    -- highlight high
}

-- Rosé Pine Dawn
module.light_colors = {
  fg = '#575279',     -- text
  fg_dim = '#797593', -- subtle
  bg1 = '#faf4ed',    -- base
  bg2 = '#fffaf3',    -- surface
  bg3 = '#dfdad9',    -- highlight med
  bg4 = '#f4ede8',    -- highlight low
  bg5 = '#cecacd',    -- highlight high
}

return module
