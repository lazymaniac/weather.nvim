local result = {}

result.opts = {

	-- Optional location. If not provided wttr.in will determine location by IP
	--
	-- Supported location types:
	--
	-- /paris                  # city name
	-- /~Eiffel+tower          # any location (+ for spaces)
	-- /Москва                 # Unicode name of any location in any language
	-- /muc                    # airport code (3 letters)
	-- /@stackoverflow.com     # domain name
	-- /94107                  # area codes
	-- /-78.46,106.79          # GPS coordinates
	--
	-- Default: empty
	location = "",

	-- One of predefinied formats for one-line report.
	--
	-- Possible options:
	-- 1 # Preview: ☀️   +6°C
	-- 2 # Preview: ☀️   🌡️+6°C 🌬️↓4km/h
	-- 3 # Preview: Porto, Portugal: ☀️   +6°C
	-- 4 # Preview: Porto, Portugal: ☀️   🌡️+6°C 🌬️↓4km/h
	--
	-- Default: 1
	format = 1,

	-- Custom format for one-line report. If present then overwrites default format defined above
	--
	-- Source: wttr.in
	-- To specify your own custom output format, use the special %-notation:
	--
	-- Possible options:
	--     c  # Weather condition,
	--     C  # Weather condition textual name,
	--     x  # Weather condition, plain-text symbol,
	--     h  # Humidity,
	--     t  # Temperature (Actual),
	--     f  # Temperature (Feels Like),
	--     w  # Wind,
	--     l  # Location,
	--     m  # Moon phase 🌑🌒🌓🌔🌕🌖🌗🌘,
	--     M  # Moon day,
	--     p  # Precipitation (mm/3 hours),
	--     P  # Pressure (hPa),
	--     u  # UV index (1-12),
	--
	--     D  # Dawn*,
	--     S  # Sunrise*,
	--     z  # Zenith*,
	--     s  # Sunset*,
	--     d  # Dusk*,
	--     T  # Current time*,
	--     Z  # Local timezone.
	--
	-- (*times are shown in the local timezone)
	--
	-- Default: ""
	custom_format = "",

	-- Units:
	--  m  # metric (SI) (used by default everywhere except US)
	--  u  # USCS (used by default in US)
	--  M  # show wind speed in m/s
	--
	--  Default: "m"
	units = "m",

	-- Optional language.
	--
	-- Supported:
	--  am ar af be bn ca da de el et fr fa gl hi hu ia id it lt mg nb nl oc pl pt-br ro ru ta tr th uk vi zh-cn zh-tw (supported)
	--  az bg bs cy cs eo es eu fi ga hi hr hy is ja jv ka kk ko ky lv mk ml mr nl fy nn pt pt-br sk sl sr sr-lat sv sw te uz zh zu he (in progress)
	--
	--  Default: ""
	lang = "",

	-- Type of weather forecast shown in popup.
	-- Possible optins:
	-- classic # shows report as widgets
	-- rich 	 # shows report as rich text with diagrams
	--
	-- Default: "rich_text"
	forecast_type = "rich_text",
	update_interval = 15 * 60 * 1000, -- 15 Minutes in ms
}

return result
