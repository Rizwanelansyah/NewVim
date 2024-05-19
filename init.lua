vim.filetype.add({
  pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})

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
  vim.keymap.set({ "c", "i" }, "<C-S-v>", "<C-r>+")

  vim.o.guifont = "JetBrainsMono Nerd Font:h10"

  -- vim.g.neovide_padding_top = 2
  -- vim.g.neovide_padding_bottom = 2
  -- vim.g.neovide_padding_right = 2
  -- vim.g.neovide_padding_left = 2
  vim.g.neovide_window_blurred = true
  vim.g.neovide_floating_z_height = 10
  vim.g.neovide_light_angle_degrees = 45
  vim.g.neovide_light_radius = 5
  vim.g.neovide_show_border = true
  vim.g.neovide_scroll_animation_length = 0.1
  vim.g.neovide_underline_stroke_scale = 0.2
  vim.g.neovide_cursor_animation_length = 0.03
  vim.g.neovide_cursor_trail_size = 0.5
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0

  local alpha = function()
    return string.format("%x", math.floor(255 * (vim.g.transparency or 0.8)))
  end

  vim.g.neovide_transparency = 0.8
  vim.g.transparency = 0.5
  vim.g.neovide_background_color = "#000000" .. alpha()

  vim.g.neovide_hide_mouse_when_typing = true
end

require("rizwan")
