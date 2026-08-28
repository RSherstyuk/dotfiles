-- return {
-- 	"numToStr/Comment.nvim",
-- 	config = function()
-- 		require("Comment").setup({
-- 			padding = true,
-- 			toggler = { line = ",cc", block = ",cb" },
-- 			opleader = { line = ",c", block = ",b" },
-- 		})
-- 	end,
-- }
return {
	"echasnovski/mini.comment",
	version = false,
	config = function()
		require("mini.comment").setup({
			mappings = {
				comment_line = "<leader>c",

				comment = "<leader>c",
				comment_visual = "<leader>c",

				textobject = "gc",
			},
		})
	end,
}
