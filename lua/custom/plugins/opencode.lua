return {
  'NickvanDyke/opencode.nvim',
  -- snacks.nvim is loaded separately by lua/custom/plugins/snacks.lua
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition" on the type or field.
    }

    -- Required for `opts.events.reload`.
    vim.o.autoread = true

    -- Recommended/example keymaps.
    vim.keymap.set({ 'n', 'x' }, '<leader>oa', function()
      require('opencode').ask('@this: ', { submit = true })
    end, { desc = 'Ask opencode…' })

    -- Recommended/example keymaps.
    vim.keymap.set({ 'n', 'x' }, '<leader>ob', function()
      require('opencode').ask('@buffer ', { submit = true })
    end, { desc = 'Ask opencode with buffer...' })

    -- Recommended/example keymaps.
    vim.keymap.set({ 'n', 'x' }, '<leader>od', function()
      require('opencode').ask('@diagnostics ', { submit = true })
    end, { desc = 'Ask opencode with diagnostics...' })

    vim.keymap.set({ 'n', 'x' }, '<leader>oo', function()
      require('opencode').select()
    end, { desc = 'Execute opencode action…' })
    --
    -- vim.keymap.set({ 'n', 't' }, '<leader>ot', function()
    --   require('opencode').toggle()
    -- end, { desc = 'Toggle opencode' })
    --
    vim.keymap.set({ 'n', 'x' }, 'go', function()
      return require('opencode').operator '@this '
    end, { desc = 'Add range to opencode', expr = true })

    vim.keymap.set('n', 'goo', function()
      return require('opencode').operator '@this ' .. '_'
    end, { desc = 'Add line to opencode', expr = true })
  end,
}
