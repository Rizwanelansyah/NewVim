local ui = require("libs.ui")

return function(lspconfig, base)
  function copy(t)
    local t2 = {}
    for k, v in pairs(t) do
      t2[k] = v
    end
    return t2
  end

  local servers = { "emmet_ls", "html", "jsonls", "intelephense", "taplo" }

  for _, server in ipairs(servers) do
    lspconfig[server].setup(base)
  end

  do
    -- local conf = copy(base)
    lspconfig.lua_ls.setup(base)
  end

  do
    local conf = copy(base)
    conf.settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
        validate = { enable = true },
      },
    }

    lspconfig.jsonls.setup(conf)
  end

  do
    local conf = copy(base)
    conf.settings = {
      yaml = {
        schemaStore = {
          enable = true,
        },
        schemas = require('schemastore').yaml.schemas(),
      },
    }

    lspconfig.yamlls.setup(conf)
  end

  do
    local conf = copy(base)
    conf.capabilities.textDocument.completion.completionItem.snippetSupport = true
    conf.filetypes = { "css", "scss", "less", "php" }
    lspconfig.cssls.setup(conf)
  end

  do
    local conf = copy(base)
    conf.on_attach = function(client, bufnr)
      base.on_attach(client, bufnr)
      local map = require("which-key")
      map.register({
        l = {
          a = { "<CMD>RustLsp codeAction<CR>", }
        },
        r = {
          name = "Rustacean",
          d = { "<CMD>RustLsp debuggables<CR>", "Debugger Debuggables" },
          D = { "<CMD>RustLsp debug<CR>", "Debugger Debug" },
          r = { "<CMD>RustLsp runnables<CR>", "Runnables" },
          R = { "<CMD>RustLsp run<CR>", "Run" },
          t = { "<CMD>RustLsp testables<CR>", "Testables" },
          m = { "<CMD>RustLsp expandMacro<CR>", "Expand Macro" },
          ["<Up>"] = { "<CMD>RustLsp moveItem up<CR>", "Move Item Up" },
          ["<Down>"] = { "<CMD>RustLsp moveItem down<CR>", "Move Item Down" },
          e = { "<CMD>RustLsp explainError<CR>", "Explain Error" },
          C = { "<CMD>RustLsp openCargo<CR>", "Open Cargo.toml" },
          ["?"] = { "<CMD>RustLsp openDocs<CR>", "Open docs.rs" },
          M = { "<CMD>RustLsp parentModule<CR>", "Parent Module" },
          s = { function()
            ui.prompt("Filter Workspace Symbol Query:", "", function(value)
              vim.cmd("RustLsp workspaceSymbol allSymbols " .. value)
            end, function(opts)
              opts.size = {
                width = 100,
                height = 1,
              }
            end)
          end, "Filter Workspace Symbol" },
        }
      }, {
        prefix = "<leader>",
        bufnr = bufnr,
        noremap = true,
        silent = true,
        nowait = true,
      })
    end

    vim.g.rustaceanvim = {
      -- Plugin configuration
      tools = {
      },
      -- LSP configuration
      server = conf,
      -- DAP configuration
      dap = {
      },
    }
  end
end
