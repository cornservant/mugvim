-- from https://github.com/vandalt/dotfiles/blob/main/private_dot_config/nvim/lua/snacks_image_toggle.lua

local M = {}

vim.g.snacks_image_disabled = vim.g.snacks_image_disabled or false

---Patch the placement method to just hide if the `vim.g.snacks_image_disabled` variable is true
local placement = require("snacks").image.placement
local original_update = placement.update
function placement:update()
  if vim.g.snacks_image_disabled then
    self:hide()
    return
  end
  return original_update(self)
end

---Disable snacks.image by closing images and setting `vim.g.disable_snacks_image` to true
M.disable_snacks_image = function()
  -- Close all images
  require("snacks").image.doc.hover_close()
  require("snacks").image.placement.clean()

  -- For toggle
  vim.g.snacks_image_disabled = true
end

---Enable snacks.image by setting `vim.g.disable_snacks_image` to false and re-drawing buffers
M.enable_snacks_image = function()
  vim.g.snacks_image_disabled = false

  -- Trigger BufWinEnter event which snacks.image uses to update
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) then
      vim.api.nvim_exec_autocmds("BufWinEnter", {
        buffer = buf,
        modeline = false,
      })
    end
  end
end

--- Toggle snacks.image
M.toggle_snacks_image = function()
  if vim.g.snacks_image_disabled then
    M.enable_snacks_image()
  else
    M.disable_snacks_image()
  end
end

return M
