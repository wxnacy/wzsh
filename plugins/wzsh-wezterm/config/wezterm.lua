-- wezterm.lua - 推荐配置 (2026 年风格)
local wezterm = require("wezterm")
local act = wezterm.action

-- 使用 config_builder() 来获得更好的错误提示和自动补全
local config = wezterm.config_builder()

-- ==================== 外观 ====================
-- 字体配置最佳实践：
-- 更纱黑体（Sarasa Term SC）专为终端设计，中英文严格 2:1 等宽，彻底解决中文乱码/错位问题
-- 安装：brew install --cask font-sarasa-gothic
-- Hack Nerd Font Mono 作为 fallback 补充 Nerd 图标符号
config.font = wezterm.font_with_fallback({
	-- 主字体：更纱黑体终端版，中英文等宽，内置 CJK
	{ family = "JetBrains Mono", weight = "Regular" },
	-- 防止中文乱码：更纱黑体终端版，中英文等宽，内置 CJK
	{ family = "Sarasa Term SC", weight = "Regular" },
	-- fallback：补充 Nerd Font 图标符号
	{ family = "Hack Nerd Font Mono", scale = 1.0 },
	-- emoji
	"Apple Color Emoji",
})

-- 禁用连字（终端中连字通常会导致显示异常）
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

config.font_size = 16.0 -- 根据你的屏幕 DPI 调整，13~15 最舒适

-- 颜色方案（Catppuccin 已内置，直接用名字）
config.color_scheme = "Catppuccin Frappe" -- 备选: Catppuccin Frappe / Macchiato / Latte

-- 窗口
config.window_background_opacity = 0.66 -- 轻微透明
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
	-- 修改 tab 名称
	{
		key = "e",
		mods = "SUPER",
		action = act.PromptInputLine({
			description = "重命名 Tab",
			action = wezterm.action_callback(function(window, _, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},

	-- 新建窗口并打开配置文件
	{
		key = ",",
		mods = "SUPER",
		action = wezterm.action_callback(function(_, _)
			wezterm.open_with(wezterm.config_file, "wezterm")
		end),
	},

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
