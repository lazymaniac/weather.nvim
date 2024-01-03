local weather = require("weather")
local util = require("weather.util")

local result = {}

result.custom = function(formatter, alt_icons)
	local default_icons = {
		pending = "⏳",
		error = "❌",
	}
	util.table_deep_merge(alt_icons, default_icons)
	local text = alt_icons.pending
	weather.subscribe("lualine", function(update)
		if update.failure then
			vim.schedule(function()
				vim.notify("Failed to fetch weather: " .. update.failure.message, vim.log.levels.WARN)
			end)
			text = alt_icons.error
		else
			text = formatter(update.success)
		end
		vim.schedule(function()
			vim.api.nvim_command("redrawstatus")
		end)
	end)
	return function()
		return text
	end
end

return result
