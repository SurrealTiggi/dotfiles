return function()
	local SYMBOLS = require("core.symbols")

	local dap = require("dap")
	local dapui = require("dapui")
	local dap_python = require("dap-python")

	---@diagnostic disable-next-line: missing-fields
	dapui.setup({})
	require("dap-go").setup()

	require("nvim-dap-virtual-text").setup({
		-- Taken from https://github.com/tjdevries/config.nvim/blob/master/lua/custom/plugins/dap.lua
		display_callback = function(variable)
			local name = string.lower(variable.name)
			local value = string.lower(variable.value)
			if name:match("secret") or name:match("api") or value:match("secret") or value:match("api") then
				return "*****"
			end

			if #variable.value > 15 then
				return " " .. string.sub(variable.value, 1, 15) .. "... "
			end

			return " " .. variable.value
		end,
	})

	dap_python.setup("python3")

	-- Enable DAP logging for debugging
	vim.fn.setenv("NVIM_DAP_LOG_LEVEL", "DEBUG")

	-- Function to load .env file
	local function load_env_file(filepath)
		local env = {}
		local file = io.open(filepath, "r")
		if file then
			for line in file:lines() do
				local key, value = line:match("^([^=]+)=(.*)$")
				if key and value then
					-- Strip quotes from value if they exist
					value = value:gsub("^[\"'](.*)[ \"']$", "%1")
					env[key] = value
				end
			end
			file:close()
		end
		return env
	end

	-- Override Python configuration to always run main.py
	dap.configurations.python = {
		{
			type = "python",
			request = "launch",
			name = "Launch main.py",
			program = "${workspaceFolder}/main.py",
			console = "integratedTerminal",
			cwd = "${workspaceFolder}",
			env = function()
				return load_env_file(vim.fn.getcwd() .. "/.env.local")
			end,
		},
		{
			type = "python",
			request = "launch",
			name = "Launch current file",
			program = "${file}",
			console = "integratedTerminal",
			cwd = "${workspaceFolder}",
			env = function()
				return load_env_file(vim.fn.getcwd() .. "/.env.local")
			end,
		},
	}

	-- Symbols
	vim.fn.sign_define("DapBreakpoint", {
		text = SYMBOLS.misc.breakpoint,
		texthl = "",
		linehl = "",
		numhl = "",
	})

	vim.fn.sign_define("DapBreakpointRejected", {
		text = SYMBOLS.misc.stop,
		texthl = "DiagnosticSignError",
		linehl = "",
		numhl = "",
	})

	vim.fn.sign_define("DapStopped", {
		text = SYMBOLS.misc.right_light,
		texthl = "DiagnosticSignWarn",
		linehl = "Visual",
		numhl = "DiagnosticSignWarn",
	})

	-- Automatically open/close
	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end

	-- TODO: Review these
	-- dap.listeners.before.attach.dapui_config = function()
	-- ui.open()
	-- end
	-- dap.listeners.before.launch.dapui_config = function()
	-- ui.open()
	-- end
	-- dap.listeners.before.event_terminated.dapui_config = function()
	-- ui.close()
	-- end
	-- dap.listeners.before.event_exited.dapui_config = function()
	-- ui.close()
	-- end

	local opts = { noremap = true, silent = true }

	-- Keymaps
	vim.keymap.set("n", "<leader>db", function()
		dap.toggle_breakpoint()
	end, opts)

	vim.keymap.set("n", "<leader>dc", function()
		dap.continue()
	end, opts)

	vim.keymap.set("n", "<leader>do", function()
		dap.step_over()
	end, opts)

	vim.keymap.set("n", "<leader>di", function()
		dap.step_into()
	end, opts)

	vim.keymap.set("n", "<leader>dO", function()
		dap.step_out()
	end, opts)

	vim.keymap.set("n", "<leader>dq", function()
		require("dap").terminate()
		dapui.toggle()
	end, opts)

	vim.keymap.set("n", "<leader>du", function()
		dapui.toggle()
	end, opts)
end
