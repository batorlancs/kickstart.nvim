return {
  'Fildo7525/pretty_hover',
  event = 'LspAttach',
  opts = {
    border = 'rounded',
    max_width = nil,
    max_height = nil,
    toggle = false,
  },
  config = function(_, opts)
    require('pretty_hover').setup(opts)

    -- Define dim highlight groups for hover window
    vim.api.nvim_set_hl(0, 'PrettyHoverNormal', { fg = '#6c7086' }) -- Dim text color
    vim.api.nvim_set_hl(0, 'PrettyHoverBorder', { fg = '#45475a' }) -- Match existing float border
    vim.api.nvim_set_hl(0, 'PrettyHoverSeparator', { fg = '#181825' }) -- Even dimmer separator

    -- Apply dim highlights to pretty_hover windows
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'markdown',
      callback = function(ev)
        local win = vim.fn.bufwinid(ev.buf)
        if win ~= -1 then
          local win_config = vim.api.nvim_win_get_config(win)
          -- Check if it's a floating window (hover popup)
          if win_config.relative ~= '' then
            vim.api.nvim_set_option_value(
              'winhighlight',
              'Normal:PrettyHoverNormal,FloatBorder:PrettyHoverBorder',
              { win = win }
            )
            -- Add syntax match for separator lines (box-drawing characters)
            vim.fn.matchadd('PrettyHoverSeparator', '^[─━┄┅┈┉═]\\+$')
          end
        end
      end,
    })
  end,
  keys = {
    {
      'K',
      function()
        require('pretty_hover').hover()
      end,
      desc = 'LSP: Hover Documentation (Pretty)',
    },
  },
}
