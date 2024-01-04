local result = {}

result.default = {
	location = "", -- Optional location. If empty wttr.in will determine location by IP
	format = 1, -- Type of format. Values from 1 to 4
	custom_format = "", -- Custom format. If empty then format field is used
	update_interval = 15 * 60 * 1000, -- 15 Minutes in ms
}

return result
