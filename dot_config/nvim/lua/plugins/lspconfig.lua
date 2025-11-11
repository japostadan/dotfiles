return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        -- pyright = {},
        -- bashls = {},
        -- gopls = {},
        -- bicep = {},
        -- yamlls = {},
        -- marksman = {},
        -- powershell_es = {},
        -- azure_pipelines_ls = {},
        -- terraformls = {},
        -- helm_ls = {},
        -- csharp_ls = {},
      },
    },
  },
}
