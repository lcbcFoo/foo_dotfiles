-- Desktop GPU, displays, and startup.
-- NVIDIA / Wayland
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")

hl.monitor({
    output = "DP-1",
    mode = "3440x1440@59.97",
    position = "0x0",
    scale = 1.0,
})

hl.monitor({
    output = "DP-3",
    mode = "3440x1440@59.97",
    position = "0x0",
    scale = 1.0,
})

hl.monitor({
    output = "HDMI-A-1",
    mode = "1920x1080@60.00",
    position = "3440x0",
    scale = 1.0,
})

hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = "auto",
})

hl.on("hyprland.start", function()
    hl.exec_cmd("/usr/bin/protonvpn-app")
    hl.exec_cmd("~/bin/start-audio.sh")
end)
