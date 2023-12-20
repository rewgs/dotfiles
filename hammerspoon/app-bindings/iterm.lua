-- The idea here is, rather than manually remapping via hex codes in iTerm like I've been doing, I 
-- can just remap Command to Control+p once and call it a day.
--
-- source: https://github.com/wyne/awesome-hammerspoon?tab=readme-ov-file#appbindingsspoon
-- note: installed as README.md instructs.
-- TODO: automate installation of this and other Spoons.
hs.loadSpoon("AppBindings")

-- FIXME:
spoon.AppBindings:bind("iTerm", {
    -- tmux prefix
    { { 'cmd' }, { 'ctrl' }, 'p' }
})
