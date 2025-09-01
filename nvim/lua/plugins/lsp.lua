return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    {
      "mason-org/mason.nvim",
      opts = {},
    },
    "neovim/nvim-lspconfig",
  },
  opts = {
    ensure_installed = {
      "bashls",
      "cssls",
      "eslint",
      "html",
      "jsonls",
      "lua_ls",
      "pyright",
      "rust_analyzer",
      "ts_ls",
      "yamlls",
    }
  },
}
