local curl = require("plenary.curl")
local util = require("wttr.util")

local result = {}

-- Does a raw call to wttr with format query param and then returning a response
result.get_raw = function(location, format, custom_format, callback)
	if not util.is_empty(custom_format) then
		format = custom_format
	end
	local effective_url = "wttr.in/" .. location .. "?format=" .. format
	print(effective_url)
	curl.get({
		url = effective_url,
		callback = function(response)
			print("response:", response.body)
			vim.schedule(function()
				callback(response.body)
			end)
		end,
	})
end

-- Gets a response from wttr
result.get = function(location, format, custom_format, callback)
	result.get_raw(location, format, custom_format, function(response)
		callback(response.body)
	end)
end

result.get_forecast = function(location, callback)
	curl.get({
		url = "wttr.in",
		callback = function(response)
			vim.schedule(function()
				print(response.body)
				callback(response.body)
			end)
		end,
	})
end

return result