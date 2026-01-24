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
    {
      '<Tab>',
      function()
        -- If there's an active NES, jump to it or apply it
        if require('sidekick').nes_jump_or_apply() then
          return
        end
        -- If blink.cmp menu is visible, select next item
        local blink_ok, blink = pcall(require, 'blink.cmp')
        if blink_ok and blink.is_visible() then
          blink.select_next()
          return
        end
        -- Fallback to normal tab
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, false, true), 'n', false)
      end,
      mode = { 'n', 'i' },
      desc = 'NES Jump/Apply or Tab',
    },
    {
      '<S-Tab>',
      function()
        -- Jump to previous NES hunk
        if require('sidekick').nes_jump(-1) then
          return
        end
        -- If blink.cmp menu is visible, select prev item
        local blink_ok, blink = pcall(require, 'blink.cmp')
        if blink_ok and blink.is_visible() then
          blink.select_prev()
          return
        end
        -- Fallback to normal shift-tab
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<S-Tab>', true, false, true), 'n', false)
      end,
      mode = { 'n', 'i' },
      desc = 'NES Jump Prev or S-Tab',
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
