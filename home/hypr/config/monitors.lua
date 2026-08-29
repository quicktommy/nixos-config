-- Monitor wiki https://wiki.hypr.land/Configuring/Basics/Monitors/
-- Example: output can be found with hyprctl monitors. Edit variables.lua for the monitor outputs instead of here directly
-- hl.monitor({
--     output    = "MONITOR1",
--     mode      = "1920x1080@60",
--     position  = "0x0",
--     scale     = "1",
-- })

hl.monitor({
    output    = MONITOR2, -- eDP-1
    mode      = "1920x1080@59.98",
    position  = "0x360",
    scale     = "1.5",
})

hl.monitor({
    output    = MONITOR1, -- HDMI-A-1
    mode      = "1920x1080@100",
    position  = "1280x0",
    scale     = "1",
})
