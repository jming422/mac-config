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
  wezterm.run_child_process {'ln', '-s', '/opt/homebrew/opt/helix/libexec/runtime/themes/ayu_dark.toml', link}
  wezterm.run_child_process {'pkill', '-USR1', 'hx'}
end

-- Sets my Helix theme to light mode
function module.set_helix_light()
  local link = wezterm.home_dir .. '/.config/helix/themes/auto_dark_mode.toml'
  os.remove(link)
  wezterm.run_child_process {'ln', '-s', '/opt/homebrew/opt/helix/libexec/runtime/themes/ayu_light.toml', link}
  wezterm.run_child_process {'pkill', '-USR1', 'hx'}
end

-- Ayu Dark
module.dark_colors = {
  fg = '#bfbdb6',     -- active & hover fg (editor.fg)
  fg_dim = '#565b66', -- inactive & new fg (ui.fg)
  bg1 = '#0b0e14',    -- inactive_titlebar_bg (ui.bg)
  bg2 = '#0f131a',    -- active_titlebar_bg (ui.panel.bg)
  bg3 = '#0d1017',    -- inactive_tab_hover bg (editor.bg)
  bg4 = '#0b0e14',    -- new_tab & inactive_tab bg (ui.bg)
  bg5 = '#29aad6',    -- new_tab_hover & active_tab bg (syntax.tag, darkened #101010)
  gradient_from = '#39bae6', -- status line gradient (syntax.tag)
  gradient_to = '#0f131a',   -- status line gradient (ui.panel.bg)
}

-- Ayu Light
module.light_colors = {
  fg = '#5c6166',     -- active & hover fg (editor.fg)
  fg_dim = '#8a9199', -- inactive & new fg (ui.fg)
  bg1 = '#f8f9fa',    -- inactive_titlebar_bg (ui.bg)
  bg2 = '#f3f4f5',    -- active_titlebar_bg (ui.panel.bg)
  bg3 = '#fcfcfc',    -- inactive_tab_hover bg (editor.bg)
  bg4 = '#f8f9fa',    -- new_tab & inactive_tab bg (ui.bg)
  bg5 = '#65c4e4',    -- new_tab_hover & active_tab bg (syntax.tag, lightened #101010)
  gradient_from = '#55b4d4', -- status line gradient (syntax.tag)
  gradient_to = '#f3f4f5',   -- status line gradient (ui.panel.bg)
}

return module
