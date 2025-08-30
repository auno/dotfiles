return {
  "nvim-telescope/telescope.nvim",
  version = "0.1.*",
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    defaults = {
      mappings = {
        i = {
          ["<C-u>"] = false -- Revert Ctrl+U from scrolling back to clear line
        },
      }
    }
  },
  init = function()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<C-p>", builtin.find_files)
    vim.keymap.set("n", "<C-S-p>", builtin.commands)
    vim.keymap.set("n", "<C-h>", builtin.help_tags)
  end,
}
