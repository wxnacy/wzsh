--- @since 26.1.22
--- @sync entry
-- smart-open: 不管目录还是文件，都使用 open --interactive 交互式打开

local function entry()
	ya.emit("open", { interactive = true })
end

return { entry = entry }
