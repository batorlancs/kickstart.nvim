-- Collection of various small independent plugins/modules
return {
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    require('mini.surround').setup()

    -- Simple and easy statusline
    local statusline = require 'mini.statusline'

    local combine_groups = function(groups)
      local parts = vim.tbl_map(function(s)
        if type(s) == 'string' then
          return s
        end
        if type(s) ~= 'table' then
          return ''
        end

        local string_arr = vim.tbl_filter(function(x)
          return type(x) == 'string' and x ~= ''
        end, s.strings or {})
        local str = table.concat(string_arr, ' ')

        if s.hl == nil then
          return ' ' .. str .. ' '
        end

        if str:len() == 0 then
          return '%#' .. s.hl .. '#'
        end

        return string.format('%%#%s# %s ', s.hl, str)
      end, groups)

      return table.concat(parts, '')
    end

    statusline.setup {
      use_icons = vim.g.have_nerd_font,
      set_vim_settings = true,
      content = {
        active = function()
          local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 50 }
          mode = mode:sub(1, 1)
          local branch = vim.b.gitsigns_head
          local fullpath = vim.fn.expand '%:.'
          local dir, filename
          if fullpath == '' then
            dir = ''
            filename = '[No Name]'
          else
            dir = vim.fn.fnamemodify(fullpath, ':h')
            filename = vim.fn.fnamemodify(fullpath, ':t')
            if dir ~= '.' then
              dir = dir .. '/'
            else
              dir = ''
            end
          end

          local modified = vim.bo.modified and '●' or ''

          local diag = MiniStatusline.section_diagnostics { trunc_width = 50, icon = '', signs = { ERROR = '!', WARN = '?', INFO = '@', HINT = '*' } }

          return combine_groups {
            { hl = mode_hl, strings = { mode } },
            branch and string.format('%%#StatuslineBranch# %s ', branch) or '',
            '%<',
            { hl = 'MiniStatuslineFilename', strings = { string.format('%%#StatuslineDimPath#%s%%#StatuslineBrightFile#%s', dir, filename) } },
            '%=',
            { hl = 'StatuslineModified', strings = { modified } },
            diag ~= '' and string.format('%%#StatuslineBranch#%s ', diag) or '',
          }
        end,
        inactive = function()
          local fullpath = vim.fn.expand '%:.'
          local dir, filename
          if fullpath == '' then
            dir = ''
            filename = '[No Name]'
          else
            dir = vim.fn.fnamemodify(fullpath, ':h')
            filename = vim.fn.fnamemodify(fullpath, ':t')
            if dir ~= '.' then
              dir = dir .. '/'
            else
              dir = ''
            end
          end
          return combine_groups {
            { hl = 'MiniStatuslineInactive', strings = { string.format('%%#StatuslineDimPath#%s%%#StatuslineInactiveFile#%s', dir, filename) } },
          }
        end,
      },
    }

    require('mini.files').setup {
      mappings = {
        go_in = 'l',
        go_in_plus = '<CR>',
        reset = '<BS>',
        reveal_cwd = '.',
        show_help = 'g?',
        synchronize = 's',
        trim_left = '<',
        trim_right = '>',
      },
      windows = {
        preview = true,
        width_focus = 30,
        width_preview = 80,
      },
      options = {
        use_as_default_explorer = true,
        permanent_delete = false,
      },
      content = {
        filter = function(entry)
          -- Filter out parent directory entry (..) at the project root
          return entry.name ~= '..'
        end,
      },
    }

    -- Prevent navigating above project root with 'h' key
    local map_go_out = MiniFiles.config.mappings.go_out or 'h'
    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        vim.keymap.set('n', map_go_out, function()
          local cwd = vim.uv.cwd()
          local cur_entry = MiniFiles.get_fs_entry()
          local cur_dir = cur_entry and vim.fn.fnamemodify(cur_entry.path, ':h') or nil
          if cur_dir and cwd and vim.fs.normalize(cur_dir) == vim.fs.normalize(cwd) then
            return -- Already at project root, don't go out
          end
          MiniFiles.go_out()
        end, { buffer = args.data.buf_id })
      end,
    })

    -- Open the directory of the file currently being edited
    vim.keymap.set('n', '<leader>e', function()
      local buf_name = vim.api.nvim_buf_get_name(0)
      local dir_name = vim.fn.fnamemodify(buf_name, ':p:h')
      if vim.fn.filereadable(buf_name) == 1 then
        require('mini.files').open(buf_name, true)
      elseif vim.fn.isdirectory(dir_name) == 1 then
        require('mini.files').open(dir_name, true)
      else
        require('mini.files').open(vim.uv.cwd(), true)
      end
    end, { desc = 'Open mini.files (Directory of Current File or CWD)' })

    -- Open the current working directory
    vim.keymap.set('n', '<leader>E', function()
      require('mini.files').open(vim.uv.cwd(), true)
    end, { desc = 'Open mini.files (cwd)' })

    require('mini.icons').setup()

    -- Mini.diff for git diff visualization
    require('mini.diff').setup {
      view = {
        style = 'sign',
        signs = { add = '▒', change = '▒', delete = '▒' },
      },
    }
    -- Mini.diff keybinding
    vim.keymap.set('n', '<leader>go', function()
      require('mini.diff').toggle_overlay(0)
    end, { desc = 'Toggle mini.diff overlay' })
  end,
}
