-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Default springs
hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })
-- bezier = bounce, 0.05, 0.9, 0.1, 1.1

--   # Default animations, see https://wiki.hypr.land/Configuring/Animations/
--   #           NAME,          ONOFF, SPEED, CURVE,        [STYLE]
--   animation = global,        1,     10,    default
--   animation = border,        1,     5.39,  easeOutQuint
--   animation = windows,       1,     4.79,  easeOutQuint, slide
--   animation = windowsIn,     1,     4.1,   easeOutQuint, popin 20%
--   animation = windowsOut,    1,     2,  easeOutQuint, popin 20%
--   animation = fadeIn,        1,     1.73,  almostLinear
--   animation = fadeOut,       1,     1.46,  almostLinear
--   animation = fade,          1,     3.03,  quick
--   animation = layers,        1,     3.81,  easeOutQuint, popin
--   animation = layersIn,      1,     5,     easeOutQuint, popin
--   animation = layersOut,     1,     2,   linear,       fade
--   animation = fadeLayersIn,  1,     1.79,  almostLinear
--   animation = fadeLayersOut, 1,     1.39,  almostLinear
--   animation = workspaces,    1,     3,  easeInOutCubic, slidefade 20%
--   animation = workspacesIn,  1,     3,  easeInOutCubic, slidefade 20%
--   animation = workspacesOut, 1,     2,  easeInOutCubic, slidefade 20%
--   animation = zoomFactor,    1,     7,     quick
-- }
