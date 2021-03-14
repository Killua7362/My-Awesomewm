---made by killua 
pcall(require, "luarocks.loader")
-- Standard awesome library
local gears = require("gears")
local gfs = require("gears.filesystem")
local awful = require("awful")
require("awful.autofocus")
local freedesktop = require ("freedesktop")
local lain = require ("lain")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")
--autostart module
local startup = require("misc.startup")
local errorhandling = require("misc.errorhandling")
main_var=require("misc.main_var")

editor_cmd = main_var.terminal .. " -e " .. main_var.editor

local beautiful = require("beautiful")
beautiful.init("/home/conan/.config/awesome/theme.lua")
bling = require("bling")
local machi = require("layout-machi")
lain = require("lain")
--mybattery = lain.widget.bat()

require("misc.savefloats")
require("misc.better-resize")
local termfair = lain.layout.termfair
require("misc.layouts")
----testing
--testingvar1 = mybattery.bat_now.perc



bling.signal.playerctl.enable()
-- Table of layouts to cover with awful.layout.inc, order matters.


-- {{{ Menumymenu
-- Menubar configuration
menubar.utils.terminal = main_var.terminal -- Set the terminal for applications that require it
mymenu = require("decor.menu")
-- {{{ Mouse bindings

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
menu = mymenu.mymainmenu })

require("decor.bar.mybar")

--keybindings
require("bindings.mousebinding")
require("bindings.clientkeys")

awful.screen.connect_for_each_screen(function(s)
  s.quake = lain.util.quake({app = "urxvt"})
end)


require("bindings.globalkeys")

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
require("misc.tags")


-- Set keys
root.keys(globalkeys)

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
require("misc.rules")
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

require("decor.titlebar")

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
   -- bling.module.flash_focus.enable()
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

---testing



-- }}}