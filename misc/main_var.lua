

local awful = require("awful")

local _M = 
{
        terminal = "alacritty",
        editor = os.getenv("EDITOR") or "nvim",
        browser = "chromium",
        filemanager = "pcmanfm",
        launcher = "dmenu_show",
        modkey = "Mod4",
        altkey = "Mod1",
        shift = "Shift",
        ctrl = "Control",
}

return _M 