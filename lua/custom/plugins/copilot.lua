return {
  'github/copilot.vim',
  cmd = 'Copilot',
  event = 'InsertEnter',
  init = function()
    -- vim.g.copilot_no_maps = true
  end,
  -- config = function()
  --   -- Block the normal Copilot suggestions
  --   vim.api.nvim_create_augroup('github_copilot', { clear = true })
  --   vim.api.nvim_create_autocmd({ 'FileType', 'BufUnload' }, {
  --     group = 'github_copilot',
  --     callback = function(args)
  --       vim.fn['copilot#On' .. args.event]()
  --     end,
  --   })
  --   vim.fn['copilot#OnFileType']()
  -- end,
}

-- return {
--   'zbirenbaum/copilot.lua',
--   dependencies = {
--     {
--       'copilotlsp-nvim/copilot-lsp',
--       init = function()
--         vim.g.copilot_nes_debounce = 500
--       end,
--     },
--   },
--   cmd = 'Copilot',
--   event = 'InsertEnter',
--   config = function()
--     require('copilot').setup {
--       suggestion = {
--         enabled = true,
--         auto_trigger = true,
--         keymap = {
--           accept = '<M-l>',
--           accept_word = false,
--           accept_line = false,
--           next = '<M-]>',
--           prev = '<M-[>',
--           dismiss = '<M-e>',
--         },
--       },
--       nes = {
--         enabled = true,
--         keymap = {
--           accept_and_goto = '<leader>p',
--           accept = false,
--           dismiss = '<Esc>',
--         },
--       },
--     }
--   end,
-- }
