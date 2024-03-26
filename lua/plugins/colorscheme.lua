return {
	"rose-pine/neovim", name = "rose-pine",
	lazy = false,
	--default in nvim is 50
	priority = 999,
	config = function ()
		vim.cmd('colorscheme rose-pine')
	end
}

