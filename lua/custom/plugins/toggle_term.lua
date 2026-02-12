-- return {
--   {
--     'akinsho/toggleterm.nvim',
--     config = function()
--       require('toggleterm').setup()
--
--       local Terminal = require('toggleterm.terminal').Terminal
--
--       -- Create the custom 'opencode' terminal instance
--       local opencode = Terminal:new {
--         cmd = 'opencode',
--         dir = 'git_dir', -- Opens in the git root of the current project (optional)
--         direction = 'float',
--         hidden = true, -- Keeps the process running in background when closed
--         float_opts = {
--           border = 'curved',
--           width = function()
--             return math.floor(vim.o.columns * 0.9)
--           end,
--           height = function()
--             return math.floor(vim.o.lines * 0.9)
--           end,
--         },
--         -- Keymaps specifically for this terminal window
--         on_open = function(term)
--           -- Ensure we start in insert mode so we can type immediately
--           vim.cmd 'startinsert!'
--
--           -- Define the Exit/Escape key mapping
--           -- NOTE: <C-/> usually registers as <C-_> in many terminal emulators
--           local opts = { noremap = true, silent = true, buffer = term.bufnr }
--
--           -- Map Ctrl+/ to switch to Normal mode (allows you to navigate away)
--           vim.keymap.set('t', '<C-/>', [[<C-\><C-n>]], opts)
--           vim.keymap.set('t', '<C-_>', [[<C-\><C-n>]], opts)
--
--           -- Optional: Map 'q' in Normal mode to close the window
--           vim.keymap.set('n', 'q', '<cmd>close<CR>', opts)
--         end,
--       }
--
--       -- Function to toggle the specific terminal
--       local function toggle_opencode()
--         opencode:toggle()
--       end
--
--       -- Register the global leader keybinding
--       vim.keymap.set('n', '<leader>ot', toggle_opencode, { desc = 'Toggle Opencode' })
--     end,
--   },
-- }
return {
  {
    'akinsho/toggleterm.nvim',
    config = function()
      require('toggleterm').setup()

      local Terminal = require('toggleterm.terminal').Terminal

      local opencode = Terminal:new {
        cmd = 'opc',
        direction = 'float',
        hidden = true,
        float_opts = {
          border = 'rounded',
          width = function()
            return math.floor(vim.o.columns * 0.9)
          end,
          height = function()
            return math.floor(vim.o.lines * 0.9)
          end,
        },
        on_open = function(term)
          vim.cmd 'startinsert!'

          local opts = { noremap = true, silent = true, buffer = term.bufnr }

          -- The function to close/toggle the terminal
          local function toggle()
            term:toggle()
          end

          -- Map Ctrl+/ to immediately toggle (close) the window
          -- We map both keys to cover different terminal emulators
          vim.keymap.set('t', '<C-/>', toggle, opts)
          vim.keymap.set('t', '<C-_>', toggle, opts)
        end,
      }

      -- Keybinding to Open
      vim.keymap.set('n', '<leader>ot', function()
        opencode:toggle()
      end, { desc = 'Toggle Opencode' })
    end,
  },
}
