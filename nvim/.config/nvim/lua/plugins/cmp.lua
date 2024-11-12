return {
	'neovim/nvim-lspconfig',
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-nvim-lua',
	'hrsh7th/cmp-path',
	'hrsh7th/cmp-buffer',
	'hrsh7th/nvim-cmp',
	"L3MON4D3/LuaSnip",
	"onsails/lspkind.nvim",
	config = function ()

		local lspkind = require("lspkind")
		lspkind.init({})

		local cmp = require('cmp')
		cmp.setup({
			sources = {
				{name = 'nvim_lua'},
				{name = 'nvim_lsp'},
				{name = 'path'},
				{name = 'luasnip'},
				{name = 'buffer'},
			},
			snippet = {
				expand = function(args)
					require('luasnip').lsp_expand(args.body)
				end,
			},
			mapping = {
				["<C-n>"] = cmp.mapping.select_next_item( {behavior = cmp.SelectBehavior.Insert} ),
				["<C-p>"] = cmp.mapping.select_prev_item( {behavior = cmp.SelectBehavior.Insert} ),
				["<C-y>"] = cmp.mapping(
				cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Insert,
					select = true,
				}),
				{ "i", "c" }
				),
			},
			experimental = {
				native_menu = false,
				ghost_text = true,
			},
			formatting = {
				format = lspkind.cmp_format({
					mode = 'symbol', -- show only symbol annotations
					maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
					-- can also be a function to dynamically calculate max width such as 
					-- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
					ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
					show_labelDetails = true, -- show labelDetails in menu. Disabled by default

					-- The function below will be called before any actual modifications from lspkind
					-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
				})
			}
		})
		require('lspkind').init({
			-- DEPRECATED (use mode instead): enables text annotations
			--
			-- default: true
			-- with_text = true,

			-- defines how annotations are shown
			-- default: symbol
			-- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
			mode = 'symbol_text',

			-- default symbol map
			-- can be either 'default' (requires nerd-fonts font) or
			-- 'codicons' for codicon preset (requires vscode-codicons font)
			--
			-- default: 'default'
			preset = 'codicons',

			-- override preset symbols
			--
			-- default: {}
			symbol_map = {
				Text = "󰉿",
				Method = "󰆧",
				Function = "󰊕",
				Constructor = "",
				Field = "󰜢",
				Variable = "󰀫",
				Class = "󰠱",
				Interface = "",
				Module = "",
				Property = "󰜢",
				Unit = "󰑭",
				Value = "󰎠",
				Enum = "",
				Keyword = "󰌋",
				Snippet = "",
				Color = "󰏘",
				File = "󰈙",
				Reference = "󰈇",
				Folder = "󰉋",
				EnumMember = "",
				Constant = "󰏿",
				Struct = "󰙅",
				Event = "",
				Operator = "󰆕",
				TypeParameter = "",
			},
		})

		require("luasnip.loaders.from_lua").load({ paths = "~/.config/snippets" })
		local ls = require('luasnip')
		ls.config.set_config {
			history = false,
			updateevents = "TextChanged",
		}

		-- for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/custom/snippets/*.lua", true)) do
		--     loadfile(ft_path)()
		--     print(ft_path)
		-- end

		vim.keymap.set({ "i", "s" }, "<c-k>", function()
			if ls.expand_or_jumpable() then
				ls.expand_or_jump()
			end
		end, {silent = true, desc="Jump to next Inset Node"})

		vim.keymap.set({ "i", "s" }, "<c-j>", function()
			if ls.jumpable(-1) then
				ls.jump(-1)
			end
		end, {silent = true, desc="Jump to prev Insert Node"})
	end
}
