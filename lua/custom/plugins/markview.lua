return {
  'OXY2DEV/markview.nvim',
  lazy = false,

  -- Completion for `blink.cmp`
  dependencies = { 'saghen/blink.cmp' },

  keys = {
    { '<leader>mt', '<cmd>Markview toggle<cr>', desc = 'Markview Toggle' },
    { '<leader>ms', '<cmd>Markview splitToggle<cr>', desc = 'Markview Split Toggle' },
  },
}
