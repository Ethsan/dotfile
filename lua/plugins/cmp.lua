return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require("cmp")
    local auto_select = true
    opts.experimental = { ghost_text = false }
    opts.mapping = cmp.mapping.preset.insert({
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<CR>"] = LazyVim.cmp.confirm({ select = auto_select }),
      ["<C-y>"] = LazyVim.cmp.confirm({ select = true }),
      ["<S-CR>"] = function(fallback)
        cmp.abort()
        fallback()
      end,
      ["<C-CR>"] = function(fallback)
        cmp.abort()
        fallback()
      end,
    })
    return opts
  end,
}
