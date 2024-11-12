return {
	{
		'VonHeikemen/lsp-zero.nvim', branch = 'v4.x',
		config = function ()
			local lsp_zero = require('lsp-zero')


			local map = function(keys, func, desc)
				vim.keymap.set("n", keys, func, { desc = "LSP: " .. desc })
			end
			-- lsp_attach is where you enable features that only work
			-- if there is a language server active in the file
			local lsp_attach = function(client, bufnr)
				local opts = {buffer = bufnr}

				vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
				vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
				vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
				vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
				vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
				vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)

				vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
				map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
				map('gs', require('telescope.builtin').lsp_document_symbols, '[G]oto Document [S]ymbols')
				map('<leader>i', function ()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
				end, "[I]nlay hints")
				map('gS', require('telescope.builtin').lsp_workspace_symbols, '[G]oto Workspace [S]ymbols')
				-- map('gt', require('telescope.builtin').lsp_typ_definitions, '[G]oto [T]yp Definitions')
			end

			lsp_zero.extend_lspconfig({
				sign_text = true,
				lsp_attach = lsp_attach,
				capabilities = require('cmp_nvim_lsp').default_capabilities(),
			})

			-- require("custom.snippets.lua")
			require('mason-lspconfig').setup({
				handlers = {
					function(server_name)
						require('lspconfig')[server_name].setup({})
					end,
				}
			})


		end
	},
	{
	},

}
