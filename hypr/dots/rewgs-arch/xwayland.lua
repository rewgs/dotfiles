hl.config({
    xwayland = {
        enabled            = true,
        force_zero_scaling = true,
        -- use_nearest_neighbor = true,
    },
})

hl.env("GDK_SCALE",    "2")
hl.env("XCURSOR_SIZE", "32")
