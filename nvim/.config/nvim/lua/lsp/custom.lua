-- See https://github.com/jose-elias-alvarez/null-ls.nvim/issues/508
local h = require("null-ls.helpers")
local methods = require("null-ls.methods")

local DIAGNOSTICS_ON_SAVE = methods.internal.DIAGNOSTICS_ON_SAVE

return h.make_builtin({
	name = "tflint",
	meta = {
		url = "https://golangci-lint.run/",
		description = "A Go linter aggregator.",
	},
	method = DIAGNOSTICS_ON_SAVE,
	filetypes = { "terraform", "tf" },
	generator_opts = {
		command = "tflint",
		to_stdin = true,
		from_stderr = false,
		ignore_stderr = true,
		args = {
			"--format=json",
			"$DIRNAME",
		},
		format = "json",
		check_exit_code = function(code)
			return code <= 2
		end,
		on_output = function(params)
			local diags = {}
			local issues = params.output["Issues"]
			if type(issues) == "table" then
				for _, d in ipairs(issues) do
					if d.Pos.Filename == params.bufname then
						table.insert(diags, {
							source = string.format("tflint:%s", d.FromLinter),
							row = d.Pos.Line,
							col = d.Pos.Column,
							message = d.Text,
							severity = h.diagnostics.severities["warning"],
						})
					end
				end
			end
			return diags
		end,
	},
	factory = h.generator_factory,
})

-- [TRACE Fri  2 Sep 15:54:37 2022] ...ck/packer/start/null-ls.nvim/lua/null-ls/diagnostics.lua:169: received diagnostics from source 11
-- [TRACE Fri  2 Sep 15:54:37 2022] ...ck/packer/start/null-ls.nvim/lua/null-ls/diagnostics.lua:170: { {
-- code = "W391",
-- col = 0,
-- end_col = 1,
-- end_lnum = 130,
-- lnum = 130,
-- message = "blank line at end of file",
-- row = "131",
-- severity = 2,
-- source = "flake8"
-- } }

-- {
-- "issues":[],
-- "errors": [
-- { "message": "Failed to check `aws_lambda_function_deprecated_runtime`
-- rule: Failed to eval an expression in /Users/tiago/ghq/github.com/conduktor/conduktor-iac-modules/infra/aws/github-runners-lambdas/webhook/main.tf:44; Reference to undeclared input variable: An input variable with the name \"lambda_runtime\" has not been declared. This variable can be declared with a variable \"lambda_runtime\" {} block."}]}
