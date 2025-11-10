return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      html = { "prettier" }, -- use Prettier for HTML
    },
    -- optional: autoformat on save
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
}
