hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Thunar window float by default
hl.window_rule({
    match = {
        class = "^(thunar)$",
    },
    float = true,
    size = "70% 65%",
    center = true,
})

hl.window_rule({
    match = {
        class = "^(xdg-desktop-portal-gtk)$",
    },
    float = true,
    size = "70% 65%",
    center = true,
})

-- Dbeaver
hl.window_rule({
    match = {
        class = "^(DBeaver)$",
    },
    float = true,
    size = "80% 65%",
    center = true,
})

-- Blueman manager window float by default
hl.window_rule({
    match = {
        class = "^(blueman-manager)$",
    },
    float = true,
    size = "50% 55%",
    center = true,
})

-- Pavucontrol window float by default
hl.window_rule({
    match = {
        class = "^(org.pulseaudio.pavucontrol)$",
    },
    float = true,
    size = "60% 55%",
    center = true,
})


