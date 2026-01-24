return {
  'saghen/blink.cmp',
  dependencies = { 'fang2hou/blink-copilot' },
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
  end,
}
