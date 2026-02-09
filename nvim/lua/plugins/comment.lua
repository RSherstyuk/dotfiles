return {
	"numToStr/Comment.nvim",
	config = function()
		require("Comment").setup({
			padding = true,
			toggler = { line = ",cc", block = ",cb" },

			opleader = { line = ",c", block = ",b" },
		})
	end,
}
