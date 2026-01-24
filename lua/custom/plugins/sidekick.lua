return {
  'folke/sidekick.nvim',
  event = 'VeryLazy',
  config = function(_, opts)
    -- Enable the copilot LSP (required for NES)
    -- This uses the lsp/copilot.lua config file
    vim.lsp.enable 'copilot'

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
      -- Enable CLI features for opencode integration
      enabled = true,
      mux = {
        enabled = true,
        backend = 'tmux', -- or "zellij"
      },
    },
  },
  keys = {
    -- Normal mode Tab for NES navigation
    {
      '<tab>',
      function()
        -- if there is a next edit, jump to it, otherwise apply it if any
        if require('sidekick').nes_jump_or_apply() then
          return -- jumped or applied
        end

        -- if you are using Neovim's native inline completions
        if vim.lsp.inline_completion.get() then
          return
        end

        -- any other things (like snippets) you want to do on <tab> go here.

        -- fall back to normal tab
        return '<tab>'
      end,
      mode = { 'i', 'n' },
      expr = true,
      desc = 'Goto/Apply Next Edit Suggestion',
    },
    {
      '<leader>aa',
      function()
        require('sidekick.cli').toggle()
      end,
      desc = 'AI Toggle',
    },
    {
      '<leader>at',
      function()
        require('sidekick.cli').send { msg = '{this}', name = 'opencode' }
      end,
      mode = { 'x', 'n' },
      desc = 'AI Send This',
    },
    {
      '<leader>af',
      function()
        require('sidekick.cli').send { msg = '{file}', name = 'opencode' }
      end,
      desc = 'AI Send File',
    },
    {
      '<leader>as',
      function()
        require('sidekick.cli').send { msg = '{selection}', name = 'opencode' }
      end,
      mode = { 'x' },
      desc = 'AI Send Visual Selection',
    },
  },
}
