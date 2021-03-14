local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local helpers = require("helpers")
local naughty = require("naughty")

local battery_bar = wibox.widget {
    max_value     = 100,
    value         = 50,
    forced_height = 20,
    forced_width  = 100,
    paddings      = 1,
    border_width  = 1,
    border_color  = beautiful.border_color,
    widget        = wibox.widget.progressbar,
}
local battery_text = wibox.widget {
    text   = "50%",
    widget = wibox.widget.textbox,
}
local battery = wibox.widget {
    battery_bar,
    battery_text,
    layout = wibox.layout.stack
}


awesome.connect_signal("evil::battery", function(value)
    battery_bar.value = value
    battery_text.text = tostring(value .. "%ear")
end)

return battery
