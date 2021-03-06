
local awful = require("awful")

beautiful = require("beautiful")
beautiful.init("~/.config/awesome/theme.lua")
local bling = require("bling")

local _M = 
{
        mylayouts = 
        {
            awful.layout.suit.floating,
            awful.layout.suit.tile,
            awful.layout.suit.tile.left,
            awful.layout.suit.tile.bottom,
            awful.layout.suit.tile.top,
            awful.layout.suit.fair,
            awful.layout.suit.fair.horizontal,
            awful.layout.suit.spiral,
            awful.layout.suit.spiral.dwindle,
            awful.layout.suit.max,
            awful.layout.suit.max.fullscreen,
            awful.layout.suit.magnifier,
            bling.layout.centered,
            bling.layout.vertical,
            bling.layout.horizontal,
        }
}


return _M