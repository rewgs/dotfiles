local M = {}

-- Focuses the most recently focused window with class `class` if one exists; otherwise runs `cmd`.
function M.focus_or_exec(cmd, class)
	return function()
		local target = nil
		for _, w in ipairs(hl.get_windows()) do
			if w.mapped and w.class == class and (not target or w.focus_history_id < target.focus_history_id) then
				target = w
			end
		end

		if target then
			hl.dispatch(hl.dsp.focus({ window = target }))
		else
			hl.dispatch(hl.dsp.exec_cmd(cmd))
		end
	end
end

return M
