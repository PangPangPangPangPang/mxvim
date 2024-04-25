return {
	{
		"Exafunction/codeium.vim",
		enabled = mxvim.enable_codeium and vim.fn.has("nvim-0.10") ~= 1,
		event = "VeryLazy",
		config = function()
			vim.g.codeium_no_map_tab = 1
			vim.keymap.set("n", "<leader>cc", function()
				return vim.fn["codeium#Chat"]()
			end, { expr = true, silent = true, desc = "Chat with codeium" })
			vim.keymap.set("i", "<C-Enter>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true, silent = true })
			vim.keymap.set("i", "<c-;>", function()
				return vim.fn["codeium#CycleCompletions"](1)
			end, { expr = true, silent = true })
			vim.keymap.set("i", "<c-'>", function()
				return vim.fn["codeium#CycleCompletions"](-1)
			end, { expr = true, silent = true })
			-- vim.keymap.set("i", "<c-x>", function()
			--   return vim.fn["codeium#Clear"]()
			-- end, { expr = true, silent = true })
		end,
	},
	{
		"monkoose/neocodeium",
		enabled = mxvim.enable_codeium and vim.fn.has("nvim-0.10") == 1,
		event = "VeryLazy",
		config = function()
			local neocodeium = require("neocodeium")
			neocodeium.setup()
			vim.keymap.set("i", "<C-Enter>", neocodeium.accept)
		end,
	},
	{
		"FittenTech/fittencode.vim",
		enabled = not mxvim.enable_codeium,
		event = "VeryLazy",
	},
	{
		"skywind3000/vim-gpt-commit",
		cmd = { "GptCommit" },
		init = function()
			local dmap = require("utils").dmap
			vim.api.nvim_create_autocmd({ "FileType" }, {
				pattern = {
					"NeogitCommitMessage",
				},
				callback = function()
					dmap({ "i", "v" }, "<c-c>", "<cmd>GptCommit<cr>")
				end,
			})
		end,

		config = function()
			-- if you don't want to set your api key directly, add to your .zshrc:
			-- export OPENAI_API_KEY='sk-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
			-- vim.g.gpt_commit_key = os.getenv("OPENAI_API_KEY")
			-- uncomment this line below to enable proxy
			-- vim.g.gpt_commit_proxy = 'socks5://127.0.0.1:1080'

			-- uncomment the following lines if you want to use Ollama:
			vim.g.gpt_commit_engine = "ollama"
			vim.g.gpt_commit_ollama_url = "http://127.0.0.1:11434/api/chat"
			vim.g.gpt_commit_ollama_model = "llama3"
			vim.g.gpt_commit_concise = 1
		end,
	},
}