return {
  'folke/sidekick.nvim',
  event = 'VeryLazy',
  config = function(_, opts)
    -- Enable the copilot LSP (required for NES)
    -- This uses the lsp/copilot.lua config file
    vim.lsp.enable('copilot')

    require('sidekick').setup(opts)
  end,
  opts = {
    nes = {
      -- Next Edit Suggestions settings
      enabled = true,
      auto_trigger = true,
      -- Visual settings for diffs
      diff = {
        show_inline = true,
        show_block = true,
      },
    },
    cli = {
      -- Disable CLI features if you don't need them
      enabled = false,
    },
  },
  keys = {
    -- Normal mode Tab for NES navigation
    {
      '<Tab>',
      function()
        if not require('sidekick').nes_jump_or_apply() then
          return '<Tab>'
        end
      end,
      mode = 'n',
      expr = true,
      desc = 'NES Jump/Apply',
    },
    {
      '<S-Tab>',
      function()
        if not require('sidekick').nes_jump(-1) then
          return '<S-Tab>'
        end
      end,
      mode = 'n',
      expr = true,
      desc = 'NES Jump Prev',
    },
    {
      '<leader>ns',
      function()
        require('sidekick').nes_toggle()
      end,
      desc = '[N]ES Toggle [S]uggestions',
    },
    {
      '<leader>na',
      function()
        require('sidekick').nes_apply_all()
      end,
      desc = '[N]ES [A]pply All',
    },
    {
      '<leader>nd',
      function()
        require('sidekick').nes_dismiss()
      end,
      desc = '[N]ES [D]ismiss',
    },
  },
}
