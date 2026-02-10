require("nvim-treesitter.install").prefer_git = true

require("nvim-treesitter").setup({
	ensure_installed = {
                "bash",
                "c",
                "clojure",
                "fennel",
                "go",
                "gomod",
                "gosum",
                "groovy",
                "java",
                "javadoc",
                "javascript",
                "kotlin",
                "lua",
                "luadoc",
                "make",
                "proto",
                "python",
                "rust",
                "scheme",
                "sql",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                -- markup
                "css",
                "html",
                "markdown",
                "markdown_inline",
                "xml",
                "asm",
                -- config
                "dot",
                "toml",
                "yaml",
                -- data
                "csv",
                "json",
                "json5",
                -- utility
                "diff",
                "disassembly",
                "dockerfile",
                "git_config",
                "git_rebase",
                "gitcommit",
                "gitignore",
                "http",
                "mermaid",
                "printf",
                "query",
                "ssh_config",

	},
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
	},
})


