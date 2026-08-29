-- Global options
vim.opt.number = true
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.autoindent = true
vim.opt.shiftwidth = 2 -- Number of spaces inserted for each indent
vim.opt.tabstop = 2 -- Number of spaces that a <Tab> counts for
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.termguicolors = true -- Enable 24-bit RGB colors
vim.opt.mouse = "a" -- Enable mouse support
vim.opt.swapfile = false -- Disable swap files (use persistent undo instead)
vim.opt.backup = false -- Disable backup files
vim.opt.undofile = true -- Enable persistent undo
vim.opt.clipboard = "unnamedplus" -- Allow Neovim to use the system clipboard
vim.opt.signcolumn = "yes" -- Always show the sign column
vim.opt.completeopt = "noselect"
vim.opt.cursorline = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Leader key
vim.g.mapleader = " "

-- Nvim tree stuff
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Prefer local version of formatters
vim.g.neoformat_try_node_exe = 1

-- Load trusted local .nvim.lua files from
vim.o.exrc = true

-- ===========================================================================
-- Plugin Management (builtin vim.pack)
-- ===========================================================================
vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-live-grep-args.nvim" },
	{ src = "https://github.com/akinsho/toggleterm.nvim" },
	{ src = "https://github.com/folke/trouble.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help" },
	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp-document-symbol" },
	{ src = "https://github.com/hrsh7th/cmp-buffer" },
	{ src = "https://github.com/hrsh7th/cmp-path" },
	{ src = "https://github.com/hrsh7th/cmp-cmdline" },
	{ src = "https://github.com/hrsh7th/nvim-cmp" },
	{ src = "https://github.com/direnv/direnv.vim" },
	{ src = "https://github.com/nvim-tree/nvim-tree.lua" },
	{ src = "https://github.com/kylechui/nvim-surround" },
	{ src = "https://github.com/mfussenegger/nvim-lint" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/rachartier/tiny-inline-diagnostic.nvim" },
	{ src = "https://github.com/akinsho/bufferline.nvim" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/lewis6991/async.nvim" },
	{ src = "https://github.com/ThePrimeagen/refactoring.nvim" },
})

-- ===========================================================================
-- LSP (builtin vim.lsp)
-- ===========================================================================
local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

vim.lsp.enable("lua_ls", {
	capabilities = capabilities,
})

vim.lsp.enable("tsgo", {
	capabilities = capabilities,
})

-- ===========================================================================
-- Plugins
-- ===========================================================================
vim.cmd.colorscheme("catppuccin-macchiato")

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettierd", "prettier", stop_after_first = true, lsp_format = "fallback" },
		javascriptreact = { "prettierd", "prettier", stop_after_first = true, lsp_format = "fallback" },
		typescript = { "prettierd", "prettier", stop_after_first = true, lsp_format = "fallback" },
		typescriptreact = { "prettierd", "prettier", stop_after_first = true, lsp_format = "fallback" },
	},
	format_on_save = {
		timeout_ms = 2000,
		lsp_format = "fallback",
	},
})

local telescope = require("telescope")
local lga_actions = require("telescope-live-grep-args.actions")
telescope.setup({
	defaults = {
		layout_config = {
			preview_width = 0.4,
			horizontal = { width = 0.94, height = 0.94 },
			vertical = { width = 0.94, height = 0.94 },
		},
	},
	extensions = {
		live_grep_args = {
			auto_quoting = true, -- enable/disable auto-quoting
			-- define mappings, e.g.
			mappings = { -- extend mappings
				i = {
					["<C-k>"] = lga_actions.quote_prompt(),
					["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
					["<C-t>"] = lga_actions.quote_prompt({ postfix = ' --iglob "!**/*.test.*"' }),
					-- freeze the current list and start a fuzzy search in the frozen list
					["<C-space>"] = lga_actions.to_fuzzy_refine,
				},
			},
		},
	},
})
telescope.load_extension("live_grep_args")

require("toggleterm").setup()
local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
	cmd = "lazygit",
	hidden = true,
	direction = "float",
	float_opts = {
		border = "double",
	},
})
function _Lazygit_toggle()
	lazygit:toggle()
end
vim.api.nvim_set_keymap("n", "<leader>gg", "<cmd>lua _Lazygit_toggle()<CR>", { noremap = true, silent = true })

local shell = Terminal:new({
	direction = "vertical",
	hidden = true,
	auto_scroll = true,
	on_open = function(term)
		vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
	end,
})
function _Shell_toggle()
	shell:toggle(80)
end
vim.api.nvim_set_keymap("n", "<leader>gt", "<cmd>lua _Shell_toggle()<CR>", { noremap = true, silent = true })

function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

local nvim_treesitter = require("nvim-treesitter")
nvim_treesitter.setup()
nvim_treesitter.install({ "lua", "typescript", "rust" })

require("trouble").setup()

local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			vim.snippet.expand(args.body)
		end,
	},
	completion = {
		autocomplete = false,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "nvim_lsp_signature_help" },
	}, {
		{ name = "buffer" },
		{ name = "path" },
	}),
})

require("nvim-tree").setup({
	view = {
		width = 80,
	},
	update_focused_file = {
		enable = true,
	},
})

require("nvim-surround").setup()

vim.env.ESLINT_D_PPID = vim.fn.getpid()
require("lint").linters_by_ft = {
	javascript = { "eslint_d" },
	typescript = { "eslint_d" },
}
vim.api.nvim_create_autocmd({ "FileType", "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})

require("lualine").setup({
	options = {
		icons_enabled = false,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_x = { "lsp_status", "filetype" },
	},
})

require("tiny-inline-diagnostic").setup({
	preset = "nonerdfont",
	options = {
		show_source = {
			enabled = true,
		},
	},
})

require("bufferline").setup({
	options = {
		indicator = {
			style = "underline",
		},
		separator_style = "thin",
		diagnostics = "nvim_lsp",
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				highlight = "Directory",
				separator = true,
			},
		},
	},
})

require("refactoring").setup()

-- ===========================================================================
-- Keymaps
-- ===========================================================================
local set = vim.keymap.set
local builtin = require("telescope.builtin")
local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
set(
	"n",
	"<leader>fg",
	":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
	{ desc = "Telescope live grep" }
)
set("n", "<leader>fc", live_grep_args_shortcuts.grep_word_under_cursor)
set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
set("n", "<leader>fo", builtin.oldfiles, { desc = "Telescope recent files" })
set("n", "<leader>fr", builtin.resume, { desc = "Telescope resume" })

set("n", "<leader>xx", "<cmd>Trouble diagnostics win.type=float focus=true<cr>", { noremap = true, silent = true })
set(
	"n",
	"<leader>xb",
	"<cmd>Trouble diagnostics filter.buf=0 win.type=float focus=true<cr>",
	{ noremap = true, silent = true }
)

set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>")
set("n", "<leader>w", "<cmd>write<cr>")
set("n", "<leader>q", "<cmd>quitall<cr>")
set("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<cr>")
set("n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
set({ "n", "x" }, "<leader>gr", function()
	require("refactoring").select_refactor()
end)

set("n", "<leader>/", ":normal gcc<cr><down>", { desc = "[/] Toggle comment line", noremap = true, silent = true })
set("v", "<leader>/", "<esc>:normal gvgc<cr>", { desc = "[/] Toggle comment block", noremap = true, silent = true })

set("n", "<leader>c", "<cmd>bdelete<cr>", { noremap = true, silent = true })

set("n", "<leader>gl", "<cmd>Gitsigns blame_line<cr>", { desc = "Git blame line" })
