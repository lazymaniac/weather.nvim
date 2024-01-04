local curl = require("plenary.curl")

local result = {}

-- Does a raw call to openweathermap, returning a table with either:
-- "success": formatted response string fetched from wttr.in
-- "failure": string with the error message
result.get_raw = function(callback)
	curl.get({
		url = "wttr.in/?format=2",
		callback = function(response)
			vim.schedule(function()
				callback(response.body)
			end)
		end,
	})
end

-- Gets a Weather object for owm
result.get = function(callback)
	result.get_raw(function(response)
		callback(response)
	end)
end

return result
