local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('config.globals')
<<<<<<< HEAD
require('config.options')
require('config.keymaps')
=======
require ('config.options')
require ('config.keymaps')
>>>>>>> 0d46229 (init commit & new color scheme)

local opts = {
	defaults = {
		lazy = true,
	},
	install = {
<<<<<<< HEAD
		colorscheme = { "rose-pine"}
	},
	rtp = {
		disabled_plugins = {
        -- "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        -- "tarPlugin",
        -- "tohtml",
        -- "tutor",
        -- "zipPlugin",
=======
		colorscheme = { "kanagawa"}
	},
	rtp = {
		disabled_plugins = {
         "gzip",
         "matchit",
         "matchparen",
         "netrwPlugin",
         "tarPlugin",
         "tohtml",
         "tutor",
         "zipPlugin",
>>>>>>> 0d46229 (init commit & new color scheme)
		}
      },
      change_detection = {
	      notify = true,
      },
<<<<<<< HEAD

=======
>>>>>>> 0d46229 (init commit & new color scheme)
}

require("lazy").setup('plugins', opts)


