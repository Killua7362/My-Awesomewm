local awful = require("awful")

do
    local autostart_apps = 
    {
        "albert",
        "nitrogen --restore",
        "xfce4-power-manager",
        --"/usr/bin/emacs --daemon &",
        "sh ~/.local/bin/swapesc.sh",
        "picom",
        "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1",
        "sh ~/.local/bin/swapesc.sh"

    }
    for _,i in pairs(autostart_apps) do
        awful.util.spawn(i)
    end
end
