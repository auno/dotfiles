-- Sync clipboard between OS and Neovim. Schedule the setting after `UiEnter` because it can
-- increase startup-time. Remove this option if you want your OS clipboard to remain independent.
-- See `:help 'clipboard'`
vim.api.nvim_create_autocmd('UIEnter', {
  callback = function()
    vim.o.clipboard = 'unnamedplus'

    local is_tmux_session = vim.env.TERM_PROGRAM == 'tmux'
    local is_ssh_session = vim.env.SSH_TTY ~= nil
    local has_xclip = vim.fn.executable('xclip') ~= 0
    local has_xsel = vim.fn.executable('xsel') ~= 0

    if is_tmux_session then
      vim.g.clipboard = "tmux"
      return
    end

    if is_ssh_session or not (has_xclip or has_xsel) then
      local function paste()
        return {
          vim.fn.split(vim.fn.getreg(''), '\n'),
          vim.fn.getregtype('')
        }
      end
      local osc52 = require("vim.ui.clipboard.osc52")
      vim.g.clipboard = {
        name = "OSC 52",
        copy = {
          ["+"] = osc52.copy("+"),
          ["*"] = osc52.copy("*"),
        },
        paste = {
          ["+"] = paste,
          ["*"] = paste,
        },
      }
    end
  end
})
