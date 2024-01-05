-- weather.nvim: A nvim plugin to display current weather status
-- Importing this module returns a set of functions which can access weather
local wttr_src = require("wttr.sources.wttr")
local default_config = require("wttr.default_config").default
local util = require("wttr.util")
local Popup = require("nui.popup")
local event = require("nui.utils.autocmd").event
local location = ""
local wttr = {}
local timer = nil

wttr.text = "Pending"

local function get_weather(format, custom_format)
	local result = wttr_src.get(location, format, custom_format, function(data)
		wttr.text = string.gsub(data, "\\%", "")
		print("text: ", wttr.text)
		vim.schedule(function()
			vim.api.nvim_command("redrawstatus")
		end)
	end)
	return result
end

function wttr.get_forecast()
	local result = wttr_src.get_forecast(location, function(data)
		vim.schedule(function()
			local popup = Popup({
				position = "50%",
				size = {
					width = 74,
					height = 43,
				},
				enter = true,
				focusable = false,
				zindex = 50,
				relative = "editor",
				border = {
					padding = {
						top = 1,
						bottom = 1,
						left = 1,
						right = 1,
					},
					style = "solid",
					text = {
						bottom = " by wttr.in ",
						bottom_align = "right",
					},
				},
				buf_options = {
					modifiable = false,
					readonly = false,
				},
				win_options = {
					winblend = 10,
					winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
				},
			})

			-- key mappings
			popup:map("n", "q", function()
				popup:unmount()
			end)
			popup:map("n", "<esc>", function()
				popup:unmount()
			end)

			-- mount/open the component
			popup:mount()

			local lines = {}
			for s in data:gmatch("[^\r\n]+") do
				s = string.gsub(s, "%c", "")
				table.insert(lines, s)
			end

			-- unmount component when cursor leaves buffer
			popup:on(event.BufLeave, function()
				popup:unmount()
			end)

			-- set content
			vim.api.nvim_buf_set_option(popup.bufnr, "modifiable", true)
			vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, lines)
			vim.api.nvim_buf_set_option(popup.bufnr, "modifiable", false)
		end)
	end)
	return result
end

-- Sets up the configuration and begins fetching weather.
wttr.setup = function(args)
	-- Merge passed in args into the default config.
	util.table_deep_merge(args or {}, default_config)
	location = default_config.location
	if not timer then
		timer = vim.loop.new_timer()
		timer:start(0, default_config.update_interval, function()
			get_weather(default_config.format, default_config.custom_format)
		end)
	end
end

return wttr
