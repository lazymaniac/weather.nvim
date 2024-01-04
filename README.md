# wttr.nvim

A mix of 'wyattjsmith1/weather.nvim' and 'ellisonleao/weather.nvim'

A simple plugin to display weather in nvim.

lualine integration

nvim-notify integration

## Installation

The usual ways. Packer below:

```lua
use {
  'lazymaniac/wttr.nvim',
  requires = {
    "nvim-lua/plenary.nvim",
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
  location = "London", -- If not provided then location will be found by your IP
  format = 1 -- 1 | 2 | 3 | 4
  custom_format = "" -- If present then overwrites default above format
}
```

## Usage

`wttr.nvim` starts a sheduler with periodic calls to `wttr.in`. Response is
extracted and saved in 'text' field. Use this filed in lualine to display current
weather.

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

### Weather forecast with notify

Call `WeatherForecast` to get weather forecast for next few days
