-- weather.nvim: A nvim plugin to display current weather status
-- Importing this module returns a set of functions which can access weather
local wttr = require("weather.sources.wttr")
local config = require("weather.default_config").default
local util = require("weather.util")

local weather = {}

local subscriptions = {}
local timer = nil

local last_update = nil
-- Subscribes to weather updates.
-- - id (any): A unique id to register the listener with. Must be used with `unsubscribe`
-- - callback (function(WeatherResult)): A callback for when weather is fetched. May be called immediately if weather is cached already.
weather.subscribe = function(id, callback)
	assert(subscriptions[id] == nil, "Subscribed to weather updates with existing id: " .. id)
	subscriptions[id] = callback
	if last_update then
		callback(last_update)
	end
end

weather.unsubscribe = function(id)
	table[id] = nil
end

local function get_weather()
	local result = wttr.get(function(data)
		last_update = data
		for _, v in pairs(subscriptions) do
			v(data)
		end
	end)
	return result
end

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
