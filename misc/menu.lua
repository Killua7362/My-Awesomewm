

local awful = require("awful")
local main_var = require("misc.main_var")
require("awful.hotkeys_popup.keys")
local beautiful = require("beautiful")

editor_cmd = main_var.terminal .. " -e " .. main_var.editor


local _M =
{
    myyawesomemenu = {
        { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
        { "manual", main_var.terminal .. " -e man awesome" },
        { "edit config", editor_cmd .. " " .. awesome.conffile },
        { "restart", awesome.restart },
        { "quit", function() awesome.quit() end },
    },
    
    myymainmenu = awful.menu({ items = { { "awesome", myyawesomemenu, beautiful.awesome_icon },
                                        { "open terminal", main_var.terminal }
                                    }
                            }),

}

return _M