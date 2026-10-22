return {
	"nvim-telescope/telescope.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local action_state = require("telescope.actions.state")

		local function open_in_diffview(prompt_bufnr)
			local entry = action_state.get_selected_entry()
			actions.close(prompt_bufnr)
			if not entry then
				return
			end

			local path = entry.path or entry.value
			if type(path) == "table" then
				path = path.path or path.value
			end
			if not path then
				return
			end

			local ok, err = pcall(vim.cmd, "DiffviewOpen -- " .. vim.fn.fnameescape(path))
			if not ok then
				vim.notify("Diffview: " .. tostring(err), vim.log.levels.WARN)
			end
		end

		telescope.setup({
			pickers = {
				git_status = {
					mappings = {
						i = { ["<C-d>"] = open_in_diffview },
						n = { ["<C-d>"] = open_in_diffview },
					},
				},
			},
		})

		pcall(telescope.load_extension, "fzf")
	end,
}
