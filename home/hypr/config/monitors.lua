-- Monitor configuration
-- See: https://wiki.hypr.land/Configuring/Monitors/
--
-- Find monitor output names and supported modes with:
-- hyprctl monitors
--
-- Set MONITOR1, MONITOR2, etc. in variables.lua.

hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "0x0",
    scale    = "1",
})
