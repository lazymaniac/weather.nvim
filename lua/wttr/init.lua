-- weather.nvim: A nvim plugin to display current weather status
-- Importing this module returns a set of functions which can access weather
local wttr_src = require("wttr.sources.wttr")
local default_config = require("wttr.default_config").default
local util = require("wttr.util")

local location = ""
local wttr = {}
local timer = nil

wttr.text = "Pending"

local function get_weather(format, custom_format)
	local result = wttr_src.get(location, format, custom_format, function(data)
		wttr.text = data

		vim.schedule(function()
			vim.api.nvim_command("redrawstatus")
		end)
	end)
	return result
end

function wttr.get_forecast()
	local result = wttr_src.get_forecast(location, function(data)
		vim.schedule(function()
			vim.notify(data)
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
			get_weather(default_config.location, default_config.format, default_config.custom_format)
		end)
	end
end

return wttr
