-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/
hl.config({
    dwindle = {
        -- FIXME: pseudotile was broken by an API update.
        -- pseudotile = true,
        force_split    = 2,
        preserve_split = true,
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/
hl.config({
    master = {
        allow_small_split    = true,
        special_scale_factor = 1,
        mfact                = 0.55,
        -- new_is_master = true,
        new_on_top           = true,
        orientation          = "right",
    },
})
