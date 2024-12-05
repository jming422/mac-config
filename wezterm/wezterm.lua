-- started from https://alexplescan.com/posts/2024/08/10/wezterm/
local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local appearance = require 'appearance'

-- https://stackoverflow.com/a/29379912
local function replace_literal(str, what, with)
    what = what:gsub("[%(%)%.%+%-%*%?%[%]%^%$%%]", "%%%1") -- escape pattern
    with = with:gsub("[%%]", "%%%%") -- escape replacement
    return str:gsub(what, with)
end

-- https://wezfurlong.org/wezterm/config/lua/PaneInformation.html?h=basename
-- Equivalent to POSIX basename(3)
-- Given "/foo/bar" returns "bar"
-- Given "c:\\foo\\bar" returns "bar"
function basename(s)
  local res, _count = s:gsub('(.*[/\\])(.*)', '%2')
  return res:gsub('%s+', '')
end

local color
if appearance.is_dark() then
  color = appearance.dark_colors
  config.color_scheme = 'Rosé Pine Moon (Gogh)'
  appearance.set_helix_dark()
else
  color = appearance.light_colors
  config.color_scheme = 'Rosé Pine Dawn (Gogh)'
  appearance.set_helix_light()
end

config.window_frame = {
  font = wezterm.font('JetBrains Mono'),
  font_size = 12,
  active_titlebar_bg = color.bg2,
  inactive_titlebar_bg = color.bg1,
  active_titlebar_fg = color.fg,
  inactive_titlebar_fg = color.fg_dim,
}

config.colors = {
  tab_bar = {
    active_tab = { bg_color = color.bg5, fg_color = color.fg },
    inactive_tab = { bg_color = color.bg4, fg_color = color.fg_dim },
    inactive_tab_hover = { bg_color = color.bg3, fg_color = color.fg },
    inactive_tab_edge = 'none',
    new_tab = { bg_color = color.bg4, fg_color = color.fg_dim },
    new_tab_hover = { bg_color = color.bg5, fg_color = color.fg }
  }
}

config.font_size = 13

config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'
config.integrated_title_button_style = 'Windows'
config.integrated_title_button_alignment = 'Left'
config.integrated_title_buttons = { 'Hide' }

config.window_padding = {
  left = '1px',
  right = '1px',
  top = '1px',
  bottom = '1px',
}

config.inactive_pane_hsb = {
  saturation = 0.8,
  brightness = 0.6,
}

config.scrollback_lines = 10000

local function get_git_repo_name(dir)
  local success, stdout, _stderr =  wezterm.run_child_process { 'git', '-C', dir, 'rev-parse', '--show-toplevel' }
  if success then
    return wezterm.nerdfonts.dev_git .. ' ' .. basename(stdout)
  end

  return nil
end

local max_cwd_segment_width = 20

local function resolve_cwd_for_status(pane)
  local cwd_url = pane:get_current_working_dir()
  if not cwd_url then
    return ""
  end

  local cwd = cwd_url.file_path

  local maybe_repo = get_git_repo_name(cwd)
  if maybe_repo then
    return maybe_repo
  end

  cwd = replace_literal(cwd, wezterm.home_dir, "~")
  if cwd:len() > max_cwd_segment_width then
    cwd = '...' .. wezterm.truncate_left(cwd, max_cwd_segment_width)
  end

  return cwd
end

local function segments_for_right_status(window, pane)
  local cwd = resolve_cwd_for_status(pane)
  local leader_indicator = window:is_focused() and (window:leader_is_active() and '◉' or '○') or '◌'

  return {
    cwd,
    wezterm.hostname(),
    leader_indicator .. ' ',
  }
end

wezterm.on('update-status', function(window, pane)
  local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
  local segments = segments_for_right_status(window, pane)

  -- Note the use of wezterm.color.parse here, this returns
  -- a Color object, which comes with functionality for lightening
  -- or darkening the colour (amongst other things).
  -- Each powerline segment is going to be coloured progressively
  -- darker/lighter depending on whether we're on a dark/light colour
  -- scheme. Let's establish the "from" and "to" bounds of our gradient.
  local gradient_to = wezterm.color.parse(color.gradient_to)
  local gradient_from = wezterm.color.parse(color.gradient_from)
  if appearance.is_dark() then
    gradient_from = gradient_from:darken(0.5)
  else
    gradient_from = gradient_from:lighten(0.5)
  end

  -- Yes, WezTerm supports creating gradients, because why not?! Although
  -- they'd usually be used for setting high fidelity gradients on your terminal's
  -- background, we'll use them here to give us a sample of the powerline segment
  -- colours we need.
  local gradient = wezterm.color.gradient(
    {
      orientation = 'Horizontal',
      colors = { gradient_from, gradient_to },
    },
    #segments -- only gives us as many colours as we have segments.
  )

  -- We'll build up the elements to send to wezterm.format in this table.
  local elements = {}

  for i, seg in ipairs(segments) do
    local is_first = i == 1

    if is_first then
      table.insert(elements, { Background = { Color = 'none' } })
    end
    table.insert(elements, { Foreground = { Color = gradient[i] } })
    table.insert(elements, { Text = SOLID_LEFT_ARROW })

    table.insert(elements, { Foreground = { Color = color.fg } })
    table.insert(elements, { Background = { Color = gradient[i] } })
    table.insert(elements, { Text = ' ' .. seg .. ' ' })
  end

  window:set_right_status(wezterm.format(elements))
end)

-- let's do some vim-like pane-switching keybinds
config.leader = { key = 'w', mods = 'ALT', timeout_milliseconds = 1000 }

local act = wezterm.action
config.keys = {
  -- double-pressing the leader sends the literal ALT-w sequence once
  { key = 'w', mods = 'LEADER|ALT', action = act.SendKey { key = 'w', mods = 'ALT' } },

  -- pane splits
  { key = 's', mods = 'LEADER', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'v', mods = 'LEADER', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'q', mods = 'LEADER', action = act.CloseCurrentPane { confirm = true } },
  -- pane navigation
  { key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection 'Left' },
  { key = 'j', mods = 'LEADER', action = act.ActivatePaneDirection 'Down' },
  { key = 'k', mods = 'LEADER', action = act.ActivatePaneDirection 'Up' },
  { key = 'l', mods = 'LEADER', action = act.ActivatePaneDirection 'Right' },
  -- maybe do pane resizing someday but tbh I don't do it much
}

return config
