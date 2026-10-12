-- Intel Yoga: native display mode and automatic scaling.
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })
hl.on("hyprland.start", function()
    hl.exec_cmd("ironbar")
end)
