return {
  'xiyaowong/transparent.nvim',
  lazy = false,
  config = function()
    require('transparent').setup {
      extra_groups = {
        'NormalFloat',
      },
    }
    require('transparent').clear_prefix 'NeoTree'
  end,
}
