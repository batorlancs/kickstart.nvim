return {
  'rachartier/tiny-inline-diagnostic.nvim',
  event = 'VeryLazy',
  priority = 1000,
  config = function()
    require('tiny-inline-diagnostic').setup {}
    vim.diagnostic.config { virtual_text = false } -- Disable Neovim's default virtual text diagnostics
    vim.keymap.set('n', '<leader>de', '<cmd>TinyInlineDiag enable<cr>', { desc = 'Enable diagnostics' })
    vim.keymap.set('n', '<leader>dd', '<cmd>TinyInlineDiag disable<cr>', { desc = 'Disable diagnostics' })
    vim.keymap.set('n', '<leader>dt', '<cmd>TinyInlineDiag toggle<cr>', { desc = 'Toggle diagnostics' })
  end,
}
