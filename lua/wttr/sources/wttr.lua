local curl = require("plenary.curl")
local util = require("wttr.util")

local result = {}

-- Gets a one-line weather report from wttr.in
result.get_oneline = function(location, format, custom_format, units, lang, callback)
	local effective_format = format
	if not util.is_empty(custom_format) then
		effective_format = custom_format
	end

	local effective_url = "wttr.in/" .. location .. "?format=" .. effective_format

	if not util.is_empty(lang) then
		effective_url = effective_url .. "&lang=" .. lang
	end

	if not util.is_empty(units) then
		effective_url = effective_url .. "&" .. units
	end

	curl.get({
		url = effective_url,
		callback = function(response)
			vim.schedule(function()
				callback(response.body)
			end)
		end,
	})
end

-- Gets weather forecast for next few days
result.get_forecast = function(type, location, units, lang, callback)
	local effective_url = "v2d.wttr.in/" .. location .. "?TF"

	if type == "classic" then
		effective_url = "wttr.in/" .. location .. "?TF"
	end

	if not util.is_empty(units) then
		effective_url = effective_url .. "&" .. units
	end

	if not util.is_empty(lang) then
		effective_url = effective_url .. "&lang=" .. lang
	end

	curl.get({
		url = effective_url,
		callback = function(response)
			vim.schedule(function()
				callback(response.body)
			end)
		end,
	})
end

return result
