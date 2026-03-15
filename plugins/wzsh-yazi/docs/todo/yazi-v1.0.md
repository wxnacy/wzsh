## TODO

- [x] `smart-open.yazi` 应该不管目录还是文件都使用 `open --interactive` ✅ 2026-03-15 12:46:00
    - 功能说明：移除目录/文件的条件判断，直接调用 `open --interactive`，让 yazi 自身处理目录和文件的交互式打开逻辑
    - 修改内容：
        - `config/plugins/smart-open.yazi/main.lua`：简化为直接 emit `open --interactive`
    - 提交记录：
        - d904676 feat(yazi): smart-open 对目录和文件都使用 open --interactive

## BUG FIX

- [x] `O` 键位在文件夹上不生效了，只能在文件上生效，以前都可以的 ✅ 2026-03-15 12:38:50
    - 需求细节
        - /Users/wxnacy/.wzsh/plugins/wzsh-yazi/config 是我的 https://github.com/sxyazi/yazi 的配置目录，升级 25.5.31 -> 26.1.22  后，所有插件更新后出现的
        - 猜测是 `smart-enter.yazi` 更新或者 `yazi` 本身更新导致的
        - `O` 键位设置在 `/Users/wxnacy/.wzsh/plugins/wzsh-yazi/config/keymap.toml` 中 `{ on = "O",         run = "open --interactive",          desc = "Open selected files interactively" },`
    - 问题原因：
        - yazi 升级后 `open --interactive` 命令对目录不生效，只对文件有效
        - `keymap` 中的 `O` 键绑定 `open --interactive`，在目录上按下时无响应
    - 解决方案：
        - 新增 `smart-open.yazi` 插件，逻辑与 `smart-enter` 类似：悬停目录时执行 `enter`，悬停文件时执行 `open --interactive`
        - 在 `prepend_keymap` 中添加 `O` 键绑定 `plugin smart-open`，优先级高于 `keymap` 中的原有绑定
    - 修改内容：
        - `config/plugins/smart-open.yazi/main.lua`：新增插件
        - `config/keymap.toml`：在 `prepend_keymap` 中添加 `O` 键绑定
    - 提交记录：
        - 189e161 fix(yazi): 修复 O 键在目录上不生效的问题
- [x] 看来是 `yazi` 更新后导致的 `open --interactive` 在目录上不生效，`https://github.com/sxyazi/yazi/blob/main/CHANGELOG.md` 这是变动日志，看下有没有说到哪个版本导致的 ✅ 2026-03-15 12:49:32
    - 分析结论：
        - v25.12.29 引入了 `mime.dir` fetcher，目录开始有 MIME 类型（`inode/directory`）
        - v25.12.29 同时移除了 opener rules 中的 `$0` 参数，修改了 `open` 命令对目录的处理逻辑
        - 升级后 `open --interactive` 直接绑定在 `keymap` 中，但 `prepend_keymap` 的 `smart-enter` 插件拦截了 `l`/`<Enter>`，而 `O` 键没有被拦截，直接走原生 `open --interactive`
        - 原生 `open --interactive` 在目录上的行为依赖 opener 规则，v25.12.29 后行为变化导致无响应
        - 已通过新增 `smart-open.yazi` 插件并在 `prepend_keymap` 中绑定 `O` 键解决（见上方 BUG FIX 记录）
