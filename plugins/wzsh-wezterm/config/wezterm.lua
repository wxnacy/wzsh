-- wezterm.lua - 推荐配置 (2026 年风格)
local wezterm = require("wezterm")
local act = wezterm.action

-- 使用 config_builder() 来获得更好的错误提示和自动补全
local config = wezterm.config_builder()

-- ==================== 外观 ====================
-- 字体（强烈推荐先安装 Nerd Font）
-- config.font = wezterm.font_with_fallback({
-- "JetBrainsMono Nerd Font",
-- "JetBrains Mono",
-- "FiraCode Nerd Font Mono",
-- })
config.font_size = 15.0 -- 根据你的屏幕 DPI 调整，13~15 最舒适

-- 颜色方案（Catppuccin 已内置，直接用名字）
config.color_scheme = "Catppuccin Frappe" -- 备选: Catppuccin Frappe / Macchiato / Latte

-- 窗口
config.window_background_opacity = 0.46 -- 轻微透明
config.macos_window_background_blur = 30 -- macOS 背景模糊（Linux 用 window_decorations）
config.window_decorations = "RESIZE" -- 隐藏标题栏，只留 resize 手柄（macOS/Linux 推荐）
config.window_padding = {
	left = "12px",
	right = "12px",
	top = "8px",
	bottom = "8px",
}
config.initial_cols = 140
config.initial_rows = 42

-- 滚动历史
config.scrollback_lines = 20000

-- Tab bar 和状态栏
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false -- 简洁风格
config.tab_bar_at_bottom = true

-- 光标
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 800
config.cursor_thickness = "2px"

-- ==================== 行为 ====================
-- 默认 shell（根据你的系统调整）
-- config.default_prog = { "/bin/zsh" } -- 或 '/usr/bin/fish', 'pwsh.exe' (Windows)

-- 自动重载配置（保存文件后立即生效）
config.check_for_updates = true -- 可选关闭更新提示

-- ==================== 快捷键 ====================
-- 清空默认键绑定（避免冲突）
config.keys = {}

-- 常用快捷键示例（可按需增删）
local keys = {
	-- 字体大小调整（像大多数终端一样）
	{ key = "=", mods = "CTRL", action = act.IncreaseFontSize },
	{ key = "-", mods = "CTRL", action = act.DecreaseFontSize },
	{ key = "0", mods = "CTRL", action = act.ResetFontSize },

	-- 复制/粘贴（用 Shift+Cmd/Ctrl）
	{ key = "c", mods = "SUPER", action = act.CopyTo("Clipboard") },
	{ key = "v", mods = "SUPER", action = act.PasteFrom("Clipboard") },

	-- 新 tab / 分屏（类似 tmux）
	{ key = "t", mods = "SUPER", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "|", mods = "SUPER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "-", mods = "SUPER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },

	-- 切换 tab / pane
	{ key = "]", mods = "SUPER", action = act.ActivateTabRelative(1) },
	{ key = "[", mods = "SUPER", action = act.ActivateTabRelative(-1) },
	{ key = "h", mods = "SUPER", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "SUPER", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "SUPER", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "SUPER", action = act.ActivatePaneDirection("Right") },

	-- 关闭
	{ key = "w", mods = "SUPER", action = act.CloseCurrentTab({ confirm = true }) },
}

for _, binding in ipairs(keys) do
	table.insert(config.keys, binding)
end

-- ==================== 其他实用设置 ====================
-- 鼠标绑定（可选：选中即复制）
config.mouse_bindings = {
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "NONE",
		action = act.Nop, -- 禁用默认选中行为，或改成 Copy
	},
}

-- 启动时默认打开的项目（可选）
config.default_cwd = wezterm.home_dir .. "/Projects"

-- 返回配置
return config
