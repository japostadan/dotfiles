return {
  -- add gruvbox
  { "wittyjudge/gruvbox-material.nvim" },

  -- Configure LazyVim to load gruvbox
  --{
  --  "LazyVim/LazyVim",
  --  opts = {
  --    colorscheme = "gruvbox-material",
  --  },
  --},
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
  -- Crafzdog
  {
    "Crafzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = function()
      return {
        transparent = true,
      }
    end,
  },
}
