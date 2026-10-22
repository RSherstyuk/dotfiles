local gitsigns = require("gitsigns")
local lualine = require("lualine")

gitsigns.setup({
	signs = {
		add = { hl = "GitGutterAdd", text = "+" },
		change = { hl = "GitGutterChange", text = "~" },
		delete = { hl = "GitGutterDelete", text = "_" },
		topdelete = { hl = "GitGutterDeleteChange", text = "‾" },
		changedelete = { hl = "GitGutterChange", text = "~" },
	},
	current_line_blame = false,
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol",
		delay = 200,
		ignore_whitespace = true,
	},
	current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
	sign_priority = 6,
	update_debounce = 100,
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns
		local function map(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
		end
		local function nav(direction)
			return function()
				if gs.nav_hunk then
					gs.nav_hunk(direction)
				else
					gs[direction .. "_hunk"]()
				end
			end
		end
		local function hunk_range()
			return { vim.fn.line("."), vim.fn.line("v") }
		end

		map("n", "]c", nav("next"), "Next git hunk")
		map("n", "[c", nav("prev"), "Previous git hunk")

		map("n", "<leader>gp", gs.preview_hunk, "Preview git hunk")
		map("n", "<leader>ga", gs.stage_hunk, "Stage git hunk")
		map("v", "<leader>ga", function()
			gs.stage_hunk(hunk_range())
		end, "Stage git hunk")
		map("n", "<leader>gr", gs.reset_hunk, "Reset git hunk")
		map("v", "<leader>gr", function()
			gs.reset_hunk(hunk_range())
		end, "Reset git hunk")
		map("n", "<leader>gA", gs.stage_buffer, "Stage buffer")
		map("n", "<leader>gR", gs.reset_buffer, "Reset buffer")
		map("n", "<leader>gl", gs.toggle_current_line_blame, "Toggle line blame")
		map("n", "<leader>gB", gs.blame_line, "Blame line")
		map("n", "<leader>gd", function()
			gs.diffthis()
		end, "Diff against index")
		map("n", "<leader>gD", function()
			gs.diffthis("HEAD")
		end, "Diff against HEAD")
		map("n", "<leader>gt", gs.toggle_deleted, "Toggle deleted lines")
	end,
})

lualine.setup({
	options = {
		theme = "gruvbox",
		section_separators = "",
		component_separators = "",
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = {
			"branch",
			{ "diff", symbols = { added = "+", modified = "~", removed = "-" } },
			"diagnostics",
		},
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },

		lualine_z = { "location" },
	},
})
