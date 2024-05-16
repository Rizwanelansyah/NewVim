---@module 'libs.ui'
local ui = require("libs.ui")

---@param bufnr integer
return function(bufnr)
  local api = require("nvim-tree.api")
  local lib = require("nvim-tree.lib")
  local plen_path = require("plenary.path")

  local function opts(desc)
    return { desc = "NvimTree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))

  vim.keymap.set('n', 'r', function()
    local node = lib.get_node_at_cursor()

    if node then
      local handler = function(new_name)
        local path = node.absolute_path:sub(1, - #node.name - 1)
        vim.cmd("silent !mv " .. path .. node.name .. " " .. path .. new_name)
      end

      ui.prompt("New Name:", node.name, handler)
    end
  end, opts("Rename"))

  -- vim.keymap.set('n', 'a', function()
  --   local node = lib.get_node_at_cursor()
  --   if node then
  --     ---@param name string
  --     local handler = function(name)
  --       ---@type Path
  --       local path = plen_path:new(node.absolute_path)
  --
  --       if path:is_dir() then
  --         ---@type Path
  --         path = path:joinpath(name)
  --         if not node.open then
  --           lib.expand_or_collapse(node)
  --         end
  --       else
  --         ---@type Path
  --         path = path:parent():joinpath(name)
  --       end
  --
  --       local res = path:absolute()
  --       if res:sub(-1) == "/" then
  --         vim.cmd("silent !mkdir -p " .. res)
  --       else
  --         vim.cmd("silent !mkdir -p $(dirname " .. res .. ") && touch " .. res)
  --       end
  --     end
  --
  --     ui.prompt("File/Directory Name:", "", handler)
  --   end
  -- end, opts("Create File/Directory"))

  vim.keymap.set('n', 'd', function()
    local node = lib.get_node_at_cursor()
    if node then
      ---@param value NuiTree.Node
      local handler = function(value)
        if value.text == "Yes" then
          vim.cmd("silent !trash " .. node.absolute_path)
        end
      end

      ui.select("Move " .. node.name .. " to Trash?", { "No", "Yes" }, handler)
    end
  end, opts("Move To Trash"))

  vim.keymap.set('n', '<Right>', function()
    local node = lib.get_node_at_cursor()
    if node then
      api.node.open.edit()
      if plen_path:new(node.absolute_path):is_file() then
        vim.cmd [[ silent NvimTreeClose ]]
      end
    end
  end, opts("Open/Expand/Collapse/CD"))
end
