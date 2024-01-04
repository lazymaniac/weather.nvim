local curl = require("plenary.curl")

local result = {}

-- Does a raw call to wttr with format query param and then returning a response
result.get_raw = function(location, format, custom_format, callback)
	curl.get({
		url = "wttr.in/?format=" .. format,
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
		url = "wttr.in",
		callback = function(response)
			vim.schedule(function()
				callback(response.body)
			end)
		end,
	})
end

return result
