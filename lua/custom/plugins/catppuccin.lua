-- Catppuccin theme configuration
-- Moved from init.lua for better organization

return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000, -- Load before other start plugins
  config = function()
    local c = require 'custom.colors'
    require('catppuccin').setup {
      flavour = 'mocha',
      no_italic = true,
      no_bold = true,
      integrations = {
        barbecue = { dim_dirname = true, bold_basename = true, dim_context = false, alt_background = false },
        cmp = true,
        gitsigns = true,
        illuminate = { enabled = true },
        markdown = true,
        mason = true,
        native_lsp = { enabled = true, inlay_hints = { background = true } },
        neogit = true,
        neotree = true,
        semantic_tokens = true,
        treesitter = true,
        treesitter_context = true,
        vimwiki = true,
        which_key = true,
      },
      custom_highlights = function(colors)
        return {
          GitSignsChange = { fg = colors.peach },
          StatuslineDimPath = { fg = c.muted, bg = '#181825' },
          StatuslineBrightFile = { fg = '#cdd6f4', bg = '#181825' },
          StatuslineInactiveFile = { fg = '#6C7086', bg = '#181825' },
          MiniStatuslineFilename = { fg = c.muted, bg = '#181825' },
          MiniStatuslineInactive = { fg = '#313244', bg = '#181825' },

          Comment = { fg = c.comment },
          ['@comment'] = { fg = c.comment },
          ['@string.documentation.python'] = { fg = c.comment },
          NormalFloat = { bg = c.popup_bg_darker },
          FloatBorder = { fg = c.popup_border_darker, bg = c.popup_bg_darker },
          BlinkCmpDoc = { bg = c.popup_bg_darker },
          BlinkCmpDocBorder = { bg = c.popup_bg_darker, fg = c.popup_border_darker },
          BlinkCmpMenu = { bg = c.popup_bg_darker },
          BlinkCmpMenuSelection = { bg = c.selection },
          BlinkCmpMenuBorder = { bg = c.popup_bg_darker, fg = c.popup_border_darker },
          BlinkCmpSignatureHelp = { bg = c.popup_bg },
          BlinkCmpSignatureHelpBorder = { bg = c.popup_bg, fg = c.popup_border },
        }
      end,
    }

    vim.cmd.colorscheme 'catppuccin'
  end,
}
