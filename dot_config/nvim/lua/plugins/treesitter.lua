return {

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
		"html",
		"css",
        "bash",
        "vimdoc",
        "html",
        "json",
        "lua",
        "python",
        "query",
        "regex",
        "vim",
        "yaml",
        "go",
        "bicep",
        "terraform",
      },
      -- Disable terraform treesitter on fixture files
      highlight = {
        disable = function(lang)
          local buf_name = vim.fn.expand("%")
          if lang == "terraform" and string.find(buf_name, "fixture") then
            return true
          end
        end,
      },
    },
  },
}
