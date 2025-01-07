vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

local function netrw_toggle()
  if vim.bo.filetype == 'netrw' then
    -- If we're in netrw, close it
    vim.cmd 'Rex'
  else
    -- If we're not in netrw, open it in the current file's directory
    vim.cmd 'Lexplore %:p:h'
  end
end

-- Map the toggle function
vim.keymap.set('n', '<leader>b', netrw_toggle, { desc = 'Toggle file explorer' })
