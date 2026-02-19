-- All colorscheme/theme configurations

return {
  -- Simple one-liner themes
  { 'Mofiqul/vscode.nvim' },
  { 'morhetz/gruvbox' },
  { 'sainnhe/everforest' },

  -- Tokyo Night
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
      require('tokyonight').setup {
        styles = {
          comments = { italic = false },
        },
      }
    end,
  },

  -- GitHub Theme
  {
    'projekt0n/github-nvim-theme',
    name = 'github-theme',
    lazy = false,
    priority = 1000,
    config = function()
      require('github-theme').setup {}
    end,
  },

  -- Koda Theme
  {
    'oskarnurm/koda.nvim',
    lazy = false,
    priority = 1000,
  },

  -- Catppuccin (full config)
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      local c = require 'custom.colors'
      require('catppuccin').setup {
        flavour = 'mocha',
        no_italic = true,
        no_bold = true,
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
  },

  -- Gruvbox Material (full config)
  {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
      local c = require 'custom.colors'
      local apply_comment_hl = function()
        vim.api.nvim_set_hl(0, 'Comment', { fg = c.comment })
        vim.api.nvim_set_hl(0, '@comment', { fg = c.comment })
      end

      vim.g.gruvbox_material_transparent_background = 1

      vim.api.nvim_create_autocmd('ColorScheme', {
        pattern = 'gruvbox-material',
        callback = apply_comment_hl,
      })
    end,
  },
}
