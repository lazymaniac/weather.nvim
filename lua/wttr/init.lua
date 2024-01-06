local wttr_src = require("wttr.sources.wttr")
local default_config = require("wttr.default_config").opts
local util = require("wttr.util")
local Popup = require("nui.popup")
local event = require("nui.utils.autocmd").event

local location, units, lang, forecast_type = "", "", "", ""
local wttr = {}
local timer = nil

wttr.text = "Pending"

-- Get one-line weather and save it in text field
local function get_weather(format, custom_format)
	local result = wttr_src.get_oneline(location, format, custom_format, units, lang, function(data)
		wttr.text = string.gsub(data, "%%", "") -- Remove % sign. Lualine doesn't like it
		vim.schedule(function()
			vim.api.nvim_command("redrawstatus")
		end)
	end)
	return result
end

-- Get forecast shown in popup
function wttr.get_forecast(cutom_location)
	local loc = location

	if not util.is_empty(cutom_location) then
		loc = cutom_location
	end

	local result = wttr_src.get_forecast(forecast_type, loc, units, lang, function(data)
		vim.schedule(function()
			local lines = {}
			for s in data:gmatch("[^\r\n]+") do
				s = string.gsub(s, "%c", "")
				table.insert(lines, s)
			end

			local classic_width = 125
			local rich_width = 74

			local popup_width = rich_width -- fallback to rich text
			if not util.is_empty(forecast_type) and forecast_type == "classic" then
				popup_width = classic_width
			end

			local popup_height = #lines

			local popup = Popup({
				position = "50%",
				size = {
					width = popup_width,
					height = popup_height,
				},
				enter = true,
				focusable = false,
				zindex = 50,
				relative = "editor",
				border = {
					padding = {
						top = 0,
						bottom = 0,
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
	units = default_config.units
	lang = default_config.lang
	forecast_type = default_config.forecast_type

	if not timer then
		timer = vim.loop.new_timer()
		timer:start(0, default_config.update_interval, function()
			get_weather(default_config.format, default_config.custom_format)
		end)
	end
end

return wttr
