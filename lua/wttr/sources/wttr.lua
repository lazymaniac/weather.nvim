local curl = require("plenary.curl")
local util = require("wttr.util")

local result = {}

-- Does a raw call to wttr with format query param and then returning a response
result.get_raw = function(location, format, custom_format, callback)
	local effective_format = format
	if not util.is_empty(custom_format) then
		effective_format = custom_format
	end

	local effective_url = "wttr.in/" .. location .. "?format=" .. effective_format

	curl.get({
		url = effective_url,
		callback = function(response)
			vim.schedule(function()
				callback(response.body)
			end)
		end,
	})
end

-- Gets a response from wttr
result.get = function(location, format, custom_format, callback)
	result.get_raw(location, format, custom_format, function(response)
		callback(response)
	end)
end

result.get_forecast = function(location, callback)
	curl.get({
		url = "v3d.wttr.in/" .. location,
		callback = function(response)
			vim.schedule(function()
				callback(response.body)
			end)
		end,
	})
end

return result
