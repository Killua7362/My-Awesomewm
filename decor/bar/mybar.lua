local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local helpers = require("helpers")
lain = require("lain")
require("evil.battery")
local function format_progress_bar(bar)
    bar.forced_width = dpi(100)
    bar.shape = helpers.rrect(beautiful.border_radius - 3)
    bar.bar_shape = helpers.rrect(beautiful.border_radius - 3)
    bar.background_color = beautiful.xcolor0
    return bar
end

mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

--battery widget
local battery_bar = require("decor.bar.widgets.battery")

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    -- Each screen has its own tag table.
    
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])
 ---removing screen doesnt kill tags
    tag.connect_signal("request::screen", function(t)
        t.selected = false
        for s in capi.screen do
            if s ~= t.screen then
                t.screen = s
                return
            end
        end
    end)
    
    lain.layout.termfair.nmaster = 3
    lain.layout.termfair.ncol    = 1
    lain.layout.termfair.center.nmaster = 3
    lain.layout.termfair.center.ncol    = 1


    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                            awful.button({ }, 1, function () awful.layout.inc( 1) end),
                            awful.button({ }, 3, function () awful.layout.inc(-1) end),
                            awful.button({ }, 4, function () awful.layout.inc( 1) end),
                            awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = require("decor.bar.modules.taglist")(s)

    -- Create a tasklist widget
    s.mytasklist = require("decor.bar.modules.tasklist")(s)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s ,height = 35})

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        expand = "none",
        
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            {{mylauncher,
            bg = beautiful.xcolor0,
            shape = helpers.rrect(beautiful.border_radius - 3),
            widget = wibox.container.background },
            margins = dpi(5),
            widget = wibox.container.margin},
            {
                {
                    s.mytaglist,
                    bg = beautiful.xcolor0,
                    shape = helpers.rrect(beautiful.border_radius - 3),
                    widget = wibox.container.background
                },
                margins = dpi(5),
                widget = wibox.container.margin
            },
            s.mypromptbox,
        },
        { --center
            {
                s.mytasklist,
                bg = beautiful.xcolor0,
                shape = helpers.rrect(beautiful.border_radius - 3),
                widget = wibox.container.background
            },
            margins = dpi(5),
            widget = wibox.container.margin
        }, 
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            mykeyboardlayout,
           awful.widget.only_on_screen({{ {wibox.widget.systray(),
             left =dpi(8),
             right =  dpi(8),
             widget = wibox.container.margin},
            bg = beautiful.xcolor0,
            shape = helpers.rrect(beautiful.border_radius - 3),
            widget = wibox.container.background},
            margins = dpi(5),
            widget = wibox.container.margin},screen[1]),
            mytextclock,
            s.mylayoutbox,
            battery_bar,
        },
    }
end)