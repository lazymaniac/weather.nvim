# wttr.nvim

A mix of 'wyattjsmith1/weather.nvim' and 'ellisonleao/weather.nvim'

A simple plugin to display weather in nvim.

lualine integration
![screenshot](https://github.com/lazymaniac/wttr.nvim/blob/main/example/lualine.jpg)
Weather report popup
![screenshot](https://github.com/lazymaniac/wttr.nvim/blob/main/example/popup.jpg)

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

A full configuration is listed below:

```lua
opts = {
  -- If not provided then location will be found by IP. It can be other location
  -- point like ~Eiffel+Tower  NOTE: ~ and + sign instead of space
  -- 
  -- Exmaple:
  -- location = "~Eiffel+Tower"
  location = "Porto",
 
  -- One of predefinied formats
  -- 1 - Preview: ☀️   +6°C
  -- 2 - Preview: ☀️   🌡️+6°C 🌬️↓4km/h
  -- 3 - Preview: Porto, Portugal: ☀️   +6°C
  -- 4 - Preview: Porto, Portugal: ☀️   🌡️+6°C 🌬️↓4km/h
  format = 1

  -- Custom format. If present then overwrites default format defined above
  --
  -- To specify your own custom output format, use the special %-notation:
  --
  -- Possible options:
  --     c    Weather condition,
  --     C    Weather condition textual name,
  --     x    Weather condition, plain-text symbol,
  --     h    Humidity,
  --     t    Temperature (Actual),
  --     f    Temperature (Feels Like),
  --     w    Wind,
  --     l    Location,
  --     m    Moon phase 🌑🌒🌓🌔🌕🌖🌗🌘,
  --     M    Moon day,
  --     p    Precipitation (mm/3 hours),
  --     P    Pressure (hPa),
  --     u    UV index (1-12),
  --
  --     D    Dawn*,
  --     S    Sunrise*,
  --     z    Zenith*,
  --     s    Sunset*,
  --     d    Dusk*,
  --     T    Current time*,
  --     Z    Local timezone.
  --
  -- (*times are shown in the local timezone)
  --
  -- My config:
  -- custom_format = '%C+%cP:%p+T:%t+F:%f+%w+%m+%P+UV:%u+Hum:%h'
  custom_format = ""
}
```

## Usage

`wttr.nvim` starts a sheduler with periodic calls to `wttr.in`. Response is
extracted and saved in 'text' field. Use this filed in lualine or other place
to display current weather.

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

Example:

```lua
lua require'wttr'.get_forecast()
```
