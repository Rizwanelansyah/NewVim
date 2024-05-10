local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local colors = require("onedark.colors")
local ui = require("libs.ui")
local path = require("plenary.path")
local Menu = require("nui.menu")
local Text = require("nui.text")
local Line = require("nui.line")
local nvim_devicon = require("nvim-web-devicons")

local FileNameBlock = {
  -- let's first set up some attributes needed by this component and it's children
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
  on_click = {
    minwid = 0,
    name = "heirline_filename_on_click",
    callback = function(self, minwid, nclicks, button, mods)
      ---@type Path
      local file = path:new(vim.api.nvim_buf_get_name(0))
      local choices = require("plenary.scandir").scan_dir(file:parent():absolute(), { add_dirs = false, depth = 1 })

      for i, choice in ipairs(choices) do
        local filename = os.capture("basename " .. choice)
        local filetype = vim.filetype.match { filename = filename }
        local fileicon, color = nvim_devicon.get_icon_color_by_filetype(filetype)
        local hl = "heirline_filetype_hl_" .. filetype
        vim.api.nvim_set_hl(0, hl, { fg = color or "white" })
        choices[i] = Menu.item(
          Line {
            Text(" " .. fileicon .. " ", hl),
            Text(filename, "Normal")
          },
          { value = choice }
        )
      end

      ui.select("Select File", choices,
        function(node)
          vim.cmd("silent e " .. node.value)
        end,
        function(opts)
          local height = math.floor(vim.o.lines / 2)
          opts.relative = 'editor'
          opts.position = {
            col = 2,
            row = vim.o.lines - 3 - height,
          }
          opts.size.width = vim.o.columns - 4
          opts.size.height = height
        end)
    end,
  },
}
-- We can now define some children separately and add them later

local FileIcon = {
  init = function(self)
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ":e")
    self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
  end,
  provider = function(self)
    return COUNT_MIDDLE_SPACE(self.icon and (" " .. self.icon .. " "))
  end,
  hl = function(self)
    return { fg = self.icon_color, bg = colors.grey }
  end
}

local FileName = {
  provider = function()
    return COUNT_MIDDLE_SPACE(vim.fn.expand("%:t") .. " ")
  end,
  hl = { fg = utils.get_highlight("Directory").fg, bg = colors.grey },
}

local FileFlags = {
  {
    condition = function()
      return vim.bo.modified
    end,
    provider = function()
      return COUNT_MIDDLE_SPACE(" ")
    end,
    hl = { fg = colors.green, bg = colors.grey },
  },
  {
    condition = function()
      return not vim.bo.modifiable or vim.bo.readonly
    end,
    provider = function()
      return COUNT_MIDDLE_SPACE(" ")
    end,
    hl = { fg = colors.orange, bg = colors.grey },
  },
}

-- Now, let's say that we want the filename color to change if the buffer is
-- modified. Of course, we could do that directly using the FileName.hl field,
-- but we'll see how easy it is to alter existing components using a "modifier"
-- component

local FileNameModifer = {
  hl = function()
    if vim.bo.modified then
      -- use `force` because we need to override the child's hl foreground
      return { fg = colors.cyan, bg = colors.grey, bold = true, force = true }
    end
  end,
}

-- let's add the children to our FileNameBlock component
return utils.insert(FileNameBlock,
  FileIcon,
  utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
  FileFlags,
  {
    provider = '%<',
  } -- this means that the statusline is cut here when there's not enough space
)
