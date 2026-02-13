-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
      local c = require 'custom.colors'
      local apply_comment_hl = function()
        vim.api.nvim_set_hl(0, 'Comment', { fg = c.comment })
        vim.api.nvim_set_hl(0, '@comment', { fg = c.comment })
      end

      vim.g.gruvbox_material_transparent_background = 1

      vim.api.nvim_create_autocmd('ColorScheme', {
        pattern = 'gruvbox-material',
        callback = apply_comment_hl,
      })

      -- vim.cmd.colorscheme 'gruvbox-material'
    end,
  },
}
