return {
  'sindrets/diffview.nvim',
  cmd = { 'DiffviewOpen', 'DiffviewFileHistory', 'DiffviewClose' },
  keys = {
    { '<leader>gv', '<Cmd>DiffviewOpen<CR>', desc = 'Diffview Open' },
    { '<leader>gV', '<Cmd>DiffviewClose<CR>', desc = 'Diffview Close' },
    { '<leader>gh', '<Cmd>DiffviewFileHistory %<CR>', desc = 'Diffview File History' },
    { '<leader>gH', '<Cmd>DiffviewFileHistory<CR>', desc = 'Diffview Branch History' },
  },
  opts = {},
}
