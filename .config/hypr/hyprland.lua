----------------
-- MONITORS --
----------------

hl.monitor({
    output = "DP-3",
    mode = "2560x1440@144",
    position = "0x0",
    scale = "auto",
})

hl.monitor({
    output = "DP-1",
    mode = "2560x1440@144",
    position = "2560x0",
    scale = "auto",
})

hl.workspace_rule({
    workspace = "1",
    monitor = "DP-3",
})

hl.workspace_rule({
    workspace = "2",
    monitor = "DP-1",
})


-------------------
-- MY PROGRAMS --
-------------------

local terminal = "alacritty"
local browser = "firefox"
local discord = "discord"
local fileManager = "dolphin"
local menu = "wofi --show drun"


---------------
-- AUTOSTART --
---------------

hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("1password --silent")
end)


---------------------------
-- ENVIRONMENT VARIABLES --
---------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_QPA_PLATFORM", "wayland")


-------------------
-- LOOK AND FEEL --
-------------------

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 20,
        border_size = 2,

        col = {
            active_border = "rgba(7aa2f777)",
            inactive_border = "rgba(595959aa)",
        },

        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding = 10,
        rounding_power = 2,

        active_opacity = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },

        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo = false,
    },
})


----------------
-- ANIMATIONS --
----------------

hl.curve("easeOutQuint", {
    type = "bezier",
    points = {{0.23, 1}, {0.32, 1}},
})

hl.curve("easeInOutCubic", {
    type = "bezier",
    points = {{0.65, 0.05}, {0.36, 1}},
})

hl.curve("linear", {
    type = "bezier",
    points = {{0, 0}, {1, 1}},
})

hl.curve("almostLinear", {
    type = "bezier",
    points = {{0.5, 0.5}, {0.75, 1.0}},
})

hl.curve("quick", {
    type = "bezier",
    points = {{0.15, 0}, {0.1, 1}},
})

local function animate(leaf, speed, bezier, style)
    hl.animation({
        leaf = leaf,
        enabled = true,
        speed = speed,
        bezier = bezier,
        style = style,
    })
end

animate("global",         10,   "default")
animate("border",         5.39, "easeOutQuint")
animate("windows",        4.79, "easeOutQuint")
animate("windowsIn",      4.1,  "easeOutQuint",  "popin 87%")
animate("windowsOut",     1.49, "linear",        "popin 87%")
animate("fadeIn",         1.73, "almostLinear")
animate("fadeOut",        1.46, "almostLinear")
animate("fade",           3.03, "quick")
animate("layers",         3.81, "easeOutQuint")
animate("layersIn",       4,    "easeOutQuint", "fade")
animate("layersOut",      1.5,  "linear",       "fade")
animate("fadeLayersIn",   1.79, "almostLinear")
animate("fadeLayersOut",  1.39, "almostLinear")
animate("workspaces",     1.94, "almostLinear", "fade")
animate("workspacesIn",   1.21, "almostLinear", "fade")
animate("workspacesOut",  1.94, "almostLinear", "fade")


-----------
-- INPUT --
-----------

hl.config({
    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",

        follow_mouse = 1,
        sensitivity = -0.5,

        touchpad = {
            natural_scroll = false,
        },
    },
})


-----------------
-- KEYBINDINGS --
-----------------

local mainMod = "SUPER"

-- Applications
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(discord))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))

-- Window management
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

-- Vim-style focus navigation
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Workspace navigation
for i = 1, 10 do
    local key = i % 10

    hl.bind(
        mainMod .. " + " .. key,
        hl.dsp.focus({ workspace = i })
    )

    hl.bind(
        mainMod .. " + SHIFT + " .. key,
        hl.dsp.window.move({ workspace = i })
    )
end

-- Special workspace (scratchpad)
hl.bind(
    mainMod .. " + S",
    hl.dsp.workspace.toggle_special("magic")
)

hl.bind(
    mainMod .. " + SHIFT + S",
    hl.dsp.window.move({ workspace = "special:magic" })
)

-- Workspace scrolling
hl.bind(
    mainMod .. " + mouse_down",
    hl.dsp.focus({ workspace = "e+1" })
)

hl.bind(
    mainMod .. " + mouse_up",
    hl.dsp.focus({ workspace = "e-1" })
)

-- Mouse window management
hl.bind(
    mainMod .. " + mouse:272",
    hl.dsp.window.drag(),
    { mouse = true }
)

hl.bind(
    mainMod .. " + mouse:273",
    hl.dsp.window.resize(),
    { mouse = true }
)

-- Volume and microphone
local volumeFlags = { locked = true, repeating = true }

hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
    volumeFlags
)

hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    volumeFlags
)

hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    volumeFlags
)

hl.bind(
    "XF86AudioMicMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    volumeFlags
)

-- Brightness
hl.bind(
    "XF86MonBrightnessUp",
    hl.dsp.exec_cmd("brightnessctl s 10%+"),
    volumeFlags
)

hl.bind(
    "XF86MonBrightnessDown",
    hl.dsp.exec_cmd("brightnessctl s 10%-"),
    volumeFlags
)

-- Media controls
local mediaFlags = { locked = true }

hl.bind(
    "XF86AudioNext",
    hl.dsp.exec_cmd("playerctl next"),
    mediaFlags
)

hl.bind(
    "XF86AudioPause",
    hl.dsp.exec_cmd("playerctl play-pause"),
    mediaFlags
)

hl.bind(
    "XF86AudioPlay",
    hl.dsp.exec_cmd("playerctl play-pause"),
    mediaFlags
)

hl.bind(
    "XF86AudioPrev",
    hl.dsp.exec_cmd("playerctl previous"),
    mediaFlags
)


-----------------------------
-- WINDOWS AND WORKSPACES --
-----------------------------

-- Prevent unwanted focus on certain XWayland windows
hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})
