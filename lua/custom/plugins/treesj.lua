return {
  'Wansmer/treesj',
  keys = {
    { '<leader>uu', '<cmd>TSJToggle<cr>', desc = 'Treesj toggle' },
    { '<leader>uy', '<cmd>TSJJoin<cr>', desc = 'Treesj join' },
    { '<leader>ui', '<cmd>TSJSplit<cr>', desc = 'Treesj split' },
  },
  dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
  config = function()
    require('treesj').setup { use_default_keymaps = false }
  end,
}
