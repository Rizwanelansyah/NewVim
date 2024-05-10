function LOG(x)
  vim.print(x)
  return x
end

function os.capture(cmd, raw)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  if raw then return s end
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')
  return s
end

if vim.g.neovide then
  vim.keymap.set("n", "<C-S-v>", "\"+p")
  vim.keymap.set("i", "<C-S-v>", "<ESC>\"+pa")
  vim.keymap.set("v", "<C-S-p>", "\"+y")

  vim.o.guifont = "FiraCode Nerd Font:h10"

  vim.g.neovide_padding_top = 2
  vim.g.neovide_padding_bottom = 2
  vim.g.neovide_padding_right = 2
  vim.g.neovide_padding_left = 2
  vim.g.neovide_floating_z_height = 10
  vim.g.neovide_light_angle_degrees = 45
  vim.g.neovide_light_radius = 5
  vim.g.neovide_show_border = true
  vim.g.neovide_scroll_animation_length = 0.2
  vim.g.neovide_underline_stroke_scale = 0.2
  vim.g.neovide_cursor_animation_length = 0.08
  vim.g.neovide_cursor_trail_size = 0.5

  local alpha = function()
    return string.format("%x", math.floor(255 * (vim.g.transparency or 0.8)))
  end

  vim.g.neovide_transparency = 0.8
  vim.g.transparency = 0.8
  vim.g.neovide_background_color = "#0f1117" .. alpha()

  vim.g.floating_opacity = 1
end

require("rizwan")
