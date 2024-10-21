vim.loader.enable()

vim.opt.termguicolors = true
require("incline").setup({})
require("fidget").setup({})
require("scope").setup({})

local get_hex = require("cokeline.hlgroups").get_hl_attr

require("cokeline").setup({
	default_hl = {
		fg = function(buffer)
			return buffer.is_focused and get_hex("ColorColumn", "bg") or get_hex("Normal", "fg")
		end,
		bg = function(buffer)
			return buffer.is_focused and get_hex("Normal", "fg") or get_hex("ColorColumn", "bg")
		end,
	},

	components = {
		{
			text = function(buffer)
				return " " .. buffer.devicon.icon
			end,
			fg = function(buffer)
				return buffer.devicon.color
			end,
		},
		{
			text = function(buffer)
				return buffer.unique_prefix
			end,
			fg = get_hex("Comment", "fg"),
			italic = true,
		},
		{
			text = function(buffer)
				return buffer.filename .. " "
			end,
			underline = function(buffer)
				return buffer.is_hovered and not buffer.is_focused
			end,
		},
		{
			text = " ",
		},
	},
})

local resession = require("resession")

resession.setup({
	autosave = {
		enabled = true,
		interval = 60,
		notify = true,
	},
	buf_filter = function(bufnr)
		local buftype = vim.bo[bufnr].buftype
		if buftype == "help" then
			return true
		end
		if buftype ~= "" and buftype ~= "acwrite" then
			return false
		end
		if vim.api.nvim_buf_get_name(bufnr) == "" then
			return false
		end
		return true
	end,
	extensions = { scope = {} },
})

local function get_session_name()
	local name = vim.fn.getcwd()
	local branch = vim.trim(vim.fn.system("git branch --show-current"))
	if vim.v.shell_error == 0 then
		return name .. branch
	else
		return name
	end
end
-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
-- 	callback = function(ev)
-- 		-- Enable completion triggered by <c-x><c-o>
-- 		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
--
-- 		-- Buffer local mappings.
-- 		-- See `:help vim.lsp.*` for documentation on any of the below functions
-- 		local opts = { buffer = ev.buf }
-- 		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
-- 		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
-- 		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
-- 		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
-- 		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
-- 		vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
-- 		vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
-- 		vim.keymap.set("n", "<space>wl", function()
-- 			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
-- 		end, opts)
-- 		vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
-- 		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
-- 		vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
-- 		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
-- 		vim.keymap.set("n", "<space>f", function()
-- 			vim.lsp.buf.format({ async = true })
-- 		end, opts)
-- 	end,
-- })
--
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		-- Only load the session if nvim was started with no args
		if vim.fn.argc(-1) == 0 then
			resession.load(get_session_name(), { dir = "dirsession", silence_errors = true })
		end
	end,
})
vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = function()
		resession.save(get_session_name(), { dir = "dirsession", notify = false })
	end,
})

local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {}
dashboard.section.header.opts.hl = "Keyword"
dashboard.section.buttons.val = {
	dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("n", "  Notebook", ":VimwikiIndex <CR>"),
	dashboard.button("c", "  Calendar", ":Calendar <CR>"),
	dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
	dashboard.button("g", "󰺄  Live grep", ":Telescope live_grep <CR>"),
	dashboard.button("q", "󰅚  Quit NVIM", ":qa<CR>"),
}

dashboard.section.footer.val = "Siema!"
dashboard.section.footer.opts.hl = "Keyword"

dashboard.config.opts.noautocmd = true

vim.cmd([[autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2]])

alpha.setup(dashboard.config)

require("gitsigns").setup({})

require("ibl").setup()

require("lualine").setup({
	options = {
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
	},
})

local npairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")

npairs.setup({
	check_ts = true,
	enable_check_bracket_line = false,
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")

local kind_icons = {
	Text = "󰉿",
	Method = "m",
	Function = "󰊕",
	Constructor = "",
	Field = "",
	Variable = "󰆧",
	Class = "󰌗",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "󰎠",
	Enum = "",
	Keyword = "󰌋",
	Snippet = "",
	Color = "󰏘",
	File = "󰈙",
	Reference = "",
	Folder = "󰉋",
	EnumMember = "",
	Constant = "󰇽",
	Struct = "",
	Event = "",
	Operator = "󰆕",
	TypeParameter = "󰊄",
	Codeium = "󰚩",
	Copilot = "",
}

local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<Tab>"] = cmp.mapping(function(fallback)
			if vim.fn.pumvisible() == 1 then
				feedkey("<C-n>", "n")
			elseif cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, {
			"i",
		}),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if vim.fn.pumvisible() == 1 then
				feedkey("<C-p>", "n")
			elseif cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, {
			"i",
		}),
	}),
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			vim_item.kind = kind_icons[vim_item.kind]
			vim_item.menu = ({
				nvim_lsp = "",
				nvim_lua = "",
				luasnip = "",
				buffer = "",
				path = "",
				emoji = "",
			})[entry.source.name]
			return vim_item
		end,
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp", keyword_length = 1 },
		{ name = "buffer", keyword_length = 3 },
		{ name = "luasnip", keyword_length = 2 },
		{ name = "path", option = { trailing_slash = true } },
		{ name = "treesitter" },
		{ name = "vimwiki-tags" },
	}),
})

vim.diagnostic.config({
	virtual_text = false,
})

-- Show line diagnostics automatically in hover window
vim.o.updatetime = 250
vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

-- LSP
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local nvim_lsp = require("lspconfig")
require("jdtls").start_or_attach({
	cmd = { "jdtls" },
	root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw", "pom.xml" }, { upward = true })[1]),
})
nvim_lsp.rnix.setup({
	capabilities = capabilities,
	autostart = true,
	cmd = { "nil" },
})
nvim_lsp.gopls.setup({
	capabilities = capabilities,
	autostart = true,
})

nvim_lsp.html.setup({
	capabilities = capabilities,
})
nvim_lsp.nixd.setup({})
nvim_lsp.tsserver.setup({})
nvim_lsp.cssls.setup({})
nvim_lsp.bashls.setup({})
nvim_lsp.clangd.setup({})
nvim_lsp.zls.setup({})
nvim_lsp.gleam.setup({})
nvim_lsp.pyright.setup({})

nvim_lsp.rust_analyzer.setup({
	capabilities = capabilities,
	filetypes = { "rust" },

	settings = {
		["rust-analyzer"] = {
			imports = {
				granularity = {
					group = "module",
				},
				prefix = "self",
			},
			cargo = {
				allFeatures = true,

				buildScripts = {
					enable = true,
				},
			},
			procMacro = {
				enable = true,
			},
		},
	},
})

require("which-key").setup({
	icons = {
		mappings = false,
	},
})

require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
	},
	additional_vim_regex_highlighting = false,
})
require("trouble").setup({})

vim.o.timeout = true
vim.o.timeoutlen = 500

local telescope = require("telescope")
telescope.setup({})
telescope.load_extension("harpoon")
telescope.load_extension("scope")

require("Comment").setup()

vim.filetype.add({
	filename = {
		[".envrc"] = "bash",
	},
})

require("colorizer").setup()

local ht = require("haskell-tools")
local bufnr = vim.api.nvim_get_current_buf()
local opts = { noremap = true, silent = true, buffer = bufnr }
-- haskell-language-server relies heavily on codeLenses,
-- so auto-refresh (see advanced configuration) is enabled by default
vim.keymap.set("n", "<space>cl", vim.lsp.codelens.run, opts)
-- Hoogle search for the type signature of the definition under the cursor
vim.keymap.set("n", "<space>hs", ht.hoogle.hoogle_signature, opts)
-- Evaluate all code snippets
vim.keymap.set("n", "<space>ea", ht.lsp.buf_eval_all, opts)
-- Toggle a GHCi repl for the current package
vim.keymap.set("n", "<leader>rr", ht.repl.toggle, opts)
-- Toggle a GHCi repl for the current buffer
vim.keymap.set("n", "<leader>rf", function()
	ht.repl.toggle(vim.api.nvim_buf_get_name(0))
end, opts)
vim.keymap.set("n", "<leader>rq", ht.repl.quit, opts)
