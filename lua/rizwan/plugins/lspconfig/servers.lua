return function(lspconfig, base)
  function copy(t)
    local t2 = {}
    for k, v in pairs(t) do
      t2[k] = v
    end
    return t2
  end

  local servers = { "rust_analyzer", "emmet_ls", "html", "cssls", "jsonls", "intelephense" }

  for _, server in ipairs(servers) do
    lspconfig[server].setup(base)
  end

  do
    local conf = copy(base)
    conf.settings = {
      Lua = {
        completion = {
          callSnippet = "Replace",
        },
      },
    }

    lspconfig.lua_ls.setup(base)
  end

end
