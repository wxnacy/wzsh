--- @since 26.1.22
--- @sync entry
-- smart-open: 对目录执行 enter，对文件执行 open --interactive

local function entry()
	local h = cx.active.current.hovered
	if h and h.cha.is_dir then
		ya.emit("enter", {})
	else
		ya.emit("open", { interactive = true })
	end
end

return { entry = entry }
