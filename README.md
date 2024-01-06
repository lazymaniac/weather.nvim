# wttr.nvim

A mix of 'wyattjsmith1/weather.nvim' and 'ellisonleao/weather.nvim'

A simple plugin to display weather in nvim.

[`lualine`](https://github.com/nvim-lualine/lualine.nvim) integration
![screenshot](https://github.com/lazymaniac/wttr.nvim/blob/main/example/lualine.jpg)

Weather report popup with [`nui.nvim`](https://github.com/MunifTanjim/nui.nvim)

Rich text presentation:
![screenshot](https://github.com/lazymaniac/wttr.nvim/blob/main/example/popup.jpg)

Classic presentation:
![screenshot](https://github.com/lazymaniac/wttr.nvim/blob/main/example/classic.jpg)

## Installation

Packer:

```lua
use {
  'lazymaniac/wttr.nvim',
  requires = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
  }
}
```

Lazy:

```lua
{
  'lazymaniac/wttr.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
  }
}
```

## Configuration

```lua
require'wttr'.setup {
  -- your options
}
```

Default configuration:

```lua
opts = {
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
  location = "",

  -- One of predefinied formats for one-line report.
  --
  -- Possible options:
  -- 1 # Preview: ☀️   +6°C
  -- 2 # Preview: ☀️   🌡️+6°C 🌬️↓4km/h
  -- 3 # Preview: Porto, Portugal: ☀️   +6°C
  -- 4 # Preview: Porto, Portugal: ☀️   🌡️+6°C 🌬️↓4km/h
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
  custom_format = "",

  -- Units:
  --  m  # metric (SI) (used by default everywhere except US)
  --  u  # USCS (used by default in US)
  --  M  # show wind speed in m/s
  units = "m",

  -- Optional language.
  --
  -- Options:
  --  am ar af be bn ca da de el et fr fa gl hi hu ia id it lt mg nb nl oc pl
  --  pt-br ro ru ta tr th uk vi zh-cn zh-tw (supported)
  -- 
  --  az bg bs cy cs eo es eu fi ga hi hr hy is ja jv ka kk ko ky lv mk ml mr
  -- nl fy nn pt pt-br sk sl sr sr-lat sv sw te uz zh zu he (in progress)
  --
  --  Default: ""
  lang = "",

  -- Type of weather forecast shown in popup.
  --
  -- Possible optins:
  -- classic # shows report as widgets
  -- rich    # shows report as rich text with diagrams
  --
  -- Default: "rich_text"
  forecast_type = "rich_text",
}
```

### My exmaple config

```lua
 {
    'lazymaniac/wttr.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
    },
    opts = {
      location = '',
      format = 1,
      custom_format = '%C+%cP:%p+T:%t+F:%f+%w+%m+%P+UV:%u+Hum:%h',
    },
    keys = {
      {
        '<leader>W',
        function()
          require('wttr').get_forecast() -- show forecast for my location
        end,
        desc = 'Weather Forecast',
      },
      {
        '<leader>w',
        function()
          require('wttr').get_forecast("London") -- show forecast for London
        end,
        desc = 'Weather Forecast - London',
      },
    },
  },
```

## Usage

`wttr.nvim` starts a scheduler with periodic calls to `wttr.in`. Response is
extracted and saved in 'text' field. Use this fieled in lualine or other place
you want to display current weather.

## Integration with [`lualine`](https://github.com/nvim-lualine/lualine.nvim)

`wttr.nvim` can integrate easily with `lualine`. To do so, you will need to use
'text' field in lualine:

```lua
require('lualine').setup {
  sections = {
    lualine_x = { "require'wttr'.text" }
  }
}
```

### Weather forecast with [`nui.nvim`](https://github.com/MunifTanjim/nui.nvim)

Call get_forecast() function to display popup with weather report 
for your location

Example:

```lua
:lua require'wttr'.get_forecast()
```

Call get_forecast(custom_location) to show weather forecast for custom location

Example:

```lua
:lua require'wttr'.get_forecast("San+Francisco")
```

To close popup press `q` or `<esc>`
