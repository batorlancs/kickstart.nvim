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
