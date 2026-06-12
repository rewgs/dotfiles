-- This file contains utility/helper functions shared by all color themes.

local M = {}

-- Returns Hyprland's rgb(rrggbb) format from a #rrggbb hex string.
function M.rgb(hex)
	return "rgb(" .. hex:sub(2) .. ")"
end

-- Returns Hyprland's rgba(rrggbbaa) format from a #rrggbb hex string.
-- alpha: 0.0–1.0 float, or a pre-formatted 2-char hex string (e.g. "ff", "80").
function M.rgba(hex, alpha)
	local a = type(alpha) == "number" and string.format("%02x", math.floor(alpha * 255 + 0.5)) or alpha
	return "rgba(" .. hex:sub(2) .. a .. ")"
end

-- Returns a shallow copy of `palette` with `overrides` merged in.
-- Override values may be new keys (custom semantic slots) or replacements for
-- existing palette keys. Either way they are treated as intentional deviations
-- from the base palette.
function M.override(palette, overrides)
    local result = {}
    for k, v in pairs(palette)   do result[k] = v end
    for k, v in pairs(overrides) do result[k] = v end
    return result
end

return M
