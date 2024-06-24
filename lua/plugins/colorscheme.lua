return {
  -- add gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    opts = {
      overrides = {
        ColorColumn = { bg = "#928374" },
      },
    },
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
