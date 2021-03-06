
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

bling.signal.playerctl.enable()

-- Table of layouts to cover with awful.layout.inc, order matters.
local mstab = bling.layout.mstab
local centered = bling.layout.centered
local vertical = bling.layout.vertical
local horizontal = bling.layout.horizontal

-- Set the layouts

tag.connect_signal("request::default_layouts", function()
    awful.layout.append_default_layouts({
        awful.layout.suit.tile, awful.layout.suit.floating, centered, mstab,
        vertical, horizontal
    })
end)-- }}}

-- {{{ Menumymenu
-- Menubar configuration
menubar.utils.terminal = main_var.terminal -- Set the terminal for applications that require it
mymenu = require("decor.menu")
-- {{{ Mouse bindings

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
menu = mymenu.mymainmenu })

require("decor.bar.mybar")
require("bindings.mousebinding")
require("bindings.clientkeys")

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ main_var.modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ main_var.modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ main_var.modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ main_var.modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end



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
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}