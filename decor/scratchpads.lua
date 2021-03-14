local awful = require("awful")
local lain = require("lain")


awful.screen.connect_for_each_screen(function(s)
    s.quake = lain.util.quake()
end)

