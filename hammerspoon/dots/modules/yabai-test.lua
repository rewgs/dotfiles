-- local yabaiOutput, _, _, _ = hs.execute("which yabai", true)
-- local yabaiOutput, _, _, _ = os.execute("which yabai")
yabai = "/opt/homebrew/bin/yabai"
local YABAI = string.gsub(yabai, "%s+", "")

local prev = "--message window --focus south"
local yabai_command = string.format("%s %s", YABAI, prev)
-- print(string.format("yabai: %s", yabai_command))
os.execute(yabai_command)
