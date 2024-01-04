-- weather.nvim: A nvim plugin to display current weather status
-- Importing this module returns a set of functions which can access weather
local wttr = require("weather.sources.wttr")
local config = require("weather.default_config").default
local util = require("weather.util")

local weather = {}

local timer = nil

local function get_weather()
	local result = wttr.get(function(data)
		weather.text = data
	end)
	return result
end

weather.text = "Pending"

-- Sets up the configuration and begins fetching weather.
weather.setup = function(args)
	-- Merge passed in args into the default config.
	util.table_deep_merge(args or {}, config)
	if not timer then
		timer = vim.loop.new_timer()
		timer:start(0, config.update_interval, function()
			get_weather()
		end)
	end
end

return weather
