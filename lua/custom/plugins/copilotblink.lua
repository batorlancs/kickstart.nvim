return {
  'saghen/blink.cmp',
  dependencies = { 'fang2hou/blink-copilot', 'folke/sidekick.nvim' },
  opts = function(_, opts)
    -- Add copilot to the sources
    opts.sources = opts.sources or {}
    opts.sources.default = opts.sources.default or {}
    table.insert(opts.sources.default, 'copilot')

    -- Configure the copilot provider
    opts.sources.providers = opts.sources.providers or {}
    opts.sources.providers.copilot = {
      name = 'copilot',
      module = 'blink-copilot',
      score_offset = 100,
      async = true,
    }

    -- Integrate Tab with sidekick NES and inline completions
    opts.keymap = opts.keymap or {}
    opts.keymap['<Tab>'] = {
      'snippet_forward',
      function()
        return require('sidekick').nes_jump_or_apply()
      end,
      function()
        return vim.lsp.inline_completion.get()
      end,
      'fallback',
    }
    opts.keymap['<S-Tab>'] = {
      'snippet_backward',
      function()
        return require('sidekick').nes_jump(-1)
      end,
      'fallback',
    }
  end,
}
