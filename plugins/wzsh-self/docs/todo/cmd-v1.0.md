## product

以下涉及的修改都只围绕 `cmd` 命令

脚本位置 `plugins/wzsh-self/bin/cmd`

每次修改脚本应该在脚本开头注释中更新脚本功能说明，脚本使用示例

脚本的主要功能是管理常用的命令行，避免时间长忘记命令怎么使用，可以搜索并把选中的命令行输入到 shell 中，等待用户手动执行。

## TODO

- [x] 增加脚本参数 `--config` `-c`，作为配置文件目录，默认 `~/Documents/Configs/wzsh/self`，没有则创建 ✅ 2026-03-07 22:06:13
    - Commit: 7cc35f5 feat(cmd): 实现命令行管理工具
- [x] 增加 `cmd add` 命令，用来添加命令，交互式输入字段，命令行 `command`、描述 `desc`，别名 `alias`。✅ 2026-03-07 22:06:13
    - 将命令数据使用 `json` 数据保存到 `${config}/cmd.json` 中
    - 每条命令自动创建 `id` 字段，自增生成
    - `alias` `id` 都是唯一值，如果重复了，应该提示报错。
    - Commit: 7cc35f5 feat(cmd): 实现命令行管理工具
- [x] 运行 `cmd` 脚本时，查询 `cmd.json` 中的命令 ✅ 2026-03-07 22:06:13
    - 使用 `fzf` 展示并筛选命令，可以筛选的字段为，别名，命令行，描述，展示除了三个字段还有 `id`
    - 选择命令，回车确认，并把 `command` 输出到当前 `shell` 环境中，用户手动回车就可以执行命令，或者修改后在执行
    - 如果按下 `cmd+回车`，则直接运行 `command`
    - Commit: 7cc35f5 feat(cmd): 实现命令行管理工具
- [x] 运行 `cmd edit [id|alias]` 脚本修改命令，可以接收 id 或者 alias 作为查找索引 ✅ 2026-03-07 22:06:13
    - 交互式，修改 `command` `desc`，应该把原值列出来，让用户修改
    - Commit: 7cc35f5 feat(cmd): 实现命令行管理工具
- [x] 运行 `cmd rm [id|alias]` 脚本删除命令，可以接收 id 或者 alias 作为查找索引 ✅ 2026-03-07 22:06:13
    - Commit: 7cc35f5 feat(cmd): 实现命令行管理工具
- [x] 将 `aliases.zsh` 中 cmd 包装函数移到 zshrc 中 ✅ 2026-03-07 22:39:04
    - Commit: cdfbcce refactor(cmd): 将 cmd 函数从 aliases.zsh 移到 zshrc

## BUG FIX

- [x] `cmd` 报错 `unsupported key: cmd-enter` ✅ 2026-03-07 22:25:04
    - 问题原因：fzf 不支持 cmd-enter 按键绑定，在 macOS 上该按键组合无法被 fzf 识别
    - 修复方案：使用 ctrl-o 替代 cmd-enter，更新脚本注释和文档说明
    - Commit: c756e5d fix(cmd): 修复 fzf 按键绑定错误
- [x] `cmd` 回车时，并没有把选择的命令输入到 `shell` 输入框中 ✅ 2026-03-07 22:33:20
    - 问题原因：print -z 只能在 zsh 交互式环境中工作，脚本作为子进程运行时无法将内容推送到父 shell 的输入缓冲区
    - 修复方案：在 aliases.zsh 中添加 cmd 函数包装器，脚本输出命令，函数使用 print -z 推送到输入缓冲区
    - Commit: b61ae94 fix(cmd): 修复命令无法输入到 shell 输入框的问题
