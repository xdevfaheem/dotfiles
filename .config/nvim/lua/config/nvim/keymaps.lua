-- toggle the cyberdream colorscheme
vim.keymap.set("n", "<leader>tt", ":CyberdreamToggleMode<CR>", { noremap = true, silent = true })

-- flick netrw file explorer (ditch neotree bloat bs)
vim.keymap.set("n", "S-|", ":Lexplore 30 %:p:h<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "\\", ":Lexplore 30<CR>", { noremap = true, silent = true })
