nnoremap <C-f> <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap ; <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>h <cmd>lua require('telescope.builtin').command_history()<cr>
nnoremap <leader>c <cmd>lua require('telescope.builtin').git_bcommits()<cr>
nnoremap <leader>m <cmd>lua require('telescope.builtin').marks()<cr>
nnoremap <leader>j <cmd>lua require('telescope.builtin').jumplist()<cr>
nnoremap <leader>f <cmd>lua require('telescope.builtin').grep_string()<cr>
" nnoremap <leader>r <cmd>lua require('telescope.builtin').registers()<cr>
nnoremap <leader>o <cmd>lua require('telescope.builtin').oldfiles()<cr>
nnoremap <leader>/ <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>
nnoremap <leader>lg <cmd>lua require('telescope.builtin').live_grep({grep_open_files=true})<CR>
"radky v bufferech
" nmap <leader>/ :Lines<CR>

lua<<EOF
require('telescope').setup{
  defaults = {
        color_devicons = false,
        layout_config = {
            width = 0.8,
            horizontal = {
                preview_width = 0.5
            }
        },
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
     buffers = {
            ignore_current_buffer = true,
            sort_lastused = true,
            layout_config = {
              preview_cutoff = 200
              }
        },
     jumplist = {
            layout_config = {
              preview_cutoff = 200
              }
        },

  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}
EOF
