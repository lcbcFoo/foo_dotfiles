-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Persistent undo (survives reboot)
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"

-- Better history / marks across restarts
vim.opt.shada = "!,'1000,<50,s10,h"

-- Align session behavior with persistence.nvim
vim.opt.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
