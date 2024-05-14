-- Maps to open a terminal
vim.api.nvim_set_keymap('n', '<Leader>tt', ':terminal<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>th', ':split | terminal<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>tv', ':vsplit | terminal<CR>', { noremap = true, silent = true })

-- Map <Leader>td to open a terminal and run the dbt commands
vim.api.nvim_set_keymap('n', '<Leader>td', ':vsplit | terminal dbt build<CR>', { noremap = true, silent = true })

-- Map <Leader>py to open a terminal and run the current Python file
vim.api.nvim_set_keymap('n', '<Leader>py', ':w<CR>:vsplit | terminal python3 %<CR>', { noremap = true, silent = true })

-- Exit terminal
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
