return {
  'nvim-neo-tree/neo-tree.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  keys = {
    {
      '<C-n>',
      function()
        require('neo-tree.command').execute {
          toggle = true,
        }
      end,
      desc = '[NEOTREE] Toggle',
    },
  },
  cmd = { 'Neotree' },
  opts = {
    default_component_configs = {
      indent = {
        with_markers = false,
      },
    },
    sources = { 'filesystem', 'buffers', 'git_status', 'document_symbols' },
    filesystem = {
      filtered_items = {
        visible = true,
        hide_by_name = {
          'node_modules',
          '.venv',
          'venv',
        },
      },
    },
  },
}
