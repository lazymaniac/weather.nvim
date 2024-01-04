local curl = require("plenary.curl")

local result = {}

-- Does a raw call to wttr with format query param and then returning a response
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

-- Gets a response from wttr
result.get = function(callback)
	result.get_raw(function(response)
		callback(response)
	end)
end

return result
