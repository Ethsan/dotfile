return {
	"luk400/vim-jukit",
	init = function()
		vim.g.jukit_output_new_os_window = 1
		-- If set to 1, opens output split in new os-window. Can be used to e.g. write code in one kitty-os-window on your primary monitor while sending code to the shell which is in a seperate kitty-os-window on another monitor.
		vim.g.jukit_outhist_new_os_window = 1
		-- Same as `g:jukit_output_new_os_window`, only for output-history-split
	end,
	keys = {
		{
			"<leader>oS",
			function()
				local env = vim.fn.input("Env name : ")
				vim.cmd("JukitOut init-conda && conda activate " .. env)
			end,
		},
	},
	ft = { "python", "json" },
}
