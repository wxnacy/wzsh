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
- [x] 运行 `cmd run [id|alias]` 脚本直接运行命令，可以接收 id 或者 alias 作为查找索引 ✅ 2026-03-07 22:44:31
    - Commit: 534c8e7 feat(cmd): 添加 run 命令并修复输入卡住问题
- [x] 运行 `cmd edit [id|alias]` 命令需要支持修改 `alias` ✅ 2026-03-08 11:11:13
    - Commit: 2581b3d feat(cmd): 增强 add 和 edit 命令功能
- [x] `add` 命令在 `alias` 为空时，默认设置一个 `uuid` ✅ 2026-03-08 11:11:13
    - Commit: 2581b3d feat(cmd): 增强 add 和 edit 命令功能
- [x] `cmd` fzf 展示列表时，如果 `alias` 是 `uuid` 样式，只展示前 8 位 ✅ 2026-03-08 11:11:13
    - Commit: 2581b3d feat(cmd): 增强 add 和 edit 命令功能
- [x] `zshrc` 中 `cmd` 包装器中 `$HOME/.wzsh` 替换为 `${WZSH_HOME}` ✅ 2026-03-08 12:28:45
    - 这一点记录到 `AGENTS.md` 中，本项目文件根目录都这样写
    - Commit: 8c6de01 refactor(cmd): 使用 WZSH_HOME 变量替代硬编码路径
- [x] `cmd` 命令，fzf 模式下，可以使用 `ctrl-y` 复制选中行的 `command`，并在header 中提示用户 ✅ 2026-03-08 15:55:30
    - Commit: 7df3f8f feat(cmd): 添加 Ctrl-Y 复制命令到剪贴板功能
- [x] `cmd` 命令现在按下 `ctrl-y` 会退出程序，不太友好，只复制，如果可以在 `fzf` 提示已复制信息，就提示，不能就不用提示了。✅ 2026-03-08 15:57:45
    - 问题原因：使用 --expect=ctrl-y 会导致按键后退出 fzf
    - 修复方案：改用 --bind="ctrl-y:execute-silent(...)" 实现复制后不退出，并在 stderr 输出提示信息
    - Commit: 9f3ed5d fix(cmd): Ctrl-Y 复制后不退出 fzf 界面
- [x] `cmd run` 运行命令时，先打印下描述信息 ✅ 2026-03-08 16:03:45
    - Commit: 5c0fe9e feat(cmd): cmd run 运行命令前打印描述信息
- [x] `ctrl-o` 直接执行时，也应该先打印下描述信息 ✅ 2026-03-08 16:05:15
    - Commit: 5de0e53 feat(cmd): Ctrl-O 执行命令前也打印描述信息
- [x] `cmd run [id|alias]` 运行命令时，可以做到参数传递。将后面的参数也都传递给最终的命令行 ✅ 2026-03-08 16:08:45
    - Commit: 0f60f4d feat(cmd): cmd run 支持参数传递
    - 比如 `alias=dl` 的命令时 `wdg download`
    - 运行 `cmd run dl 1 --name w` 可以做到直接运行 `wdg download 1 --name w`
- [x] `cmd -h` 可以获取帮助文档 ✅ 2026-03-08 16:11:30
    - Commit: a81bb90 feat(cmd): 添加 -h/--help 帮助文档功能
- [x] 将 `cmd` 详细功能细节整理到 `cmd` 脚本文档中 ✅ 2026-03-08 16:11:30
    - 已在脚本开头注释和 -h 帮助文档中详细说明所有功能
    - Commit: a81bb90 feat(cmd): 添加 -h/--help 帮助文档功能

## BUG FIX

- [x] `cmd` 报错 `unsupported key: cmd-enter` ✅ 2026-03-07 22:25:04
    - 问题原因：fzf 不支持 cmd-enter 按键绑定，在 macOS 上该按键组合无法被 fzf 识别
    - 修复方案：使用 ctrl-o 替代 cmd-enter，更新脚本注释和文档说明
    - Commit: c756e5d fix(cmd): 修复 fzf 按键绑定错误
- [x] `cmd` 回车时，并没有把选择的命令输入到 `shell` 输入框中 ✅ 2026-03-07 22:33:20
    - 问题原因：print -z 只能在 zsh 交互式环境中工作，脚本作为子进程运行时无法将内容推送到父 shell 的输入缓冲区
    - 修复方案：在 aliases.zsh 中添加 cmd 函数包装器，脚本输出命令，函数使用 print -z 推送到输入缓冲区
    - Commit: b61ae94 fix(cmd): 修复命令无法输入到 shell 输入框的问题
- [x] `cmd add` 现在会卡主不动 ✅ 2026-03-07 22:51:35
    - 问题原因：函数包装器使用 result=$(cmd "$@") 捕获了所有输出，导致交互式命令的提示信息被捕获，用户看不到，用户输入也无法正常传递给脚本
    - 修复方案：对 add 和 edit 交互式命令直接执行脚本不捕获输出，恢复脚本中的正常 read 命令
    - Commit: 598b504 fix(cmd): 修复交互式命令卡住的真正原因
- [x] `cmd run` 报错 `(eval):1: command not found: ` 但其实有这个命令，日志如下

```bash
cmd run nad
(eval):1: command not found: nvshens
░▒▓    ~/Projects/agent    master ⇡37 !6 ?2 ·································· ▼  agent   3.12    23:21:02  ▓▒░
❯ which nvshens
nvshens: aliased to website nvshens -d /Volumes/ZhiTai/xvideos/nvshens/images
```
```

- 问题原因：eval 在脚本子进程中无法访问父 shell 的别名，Ctrl-O 直接执行也有同样的问题
- 修复方案：脚本只负责输出命令不执行，run 命令和 Ctrl-O 的执行都在函数包装器中进行，使用特殊标记 __CMD_EXEC__: 标识需要执行的命令
- Commit: e104039 fix(cmd): 修复 run 命令无法执行别名的问题
- 完成时间：✅ 2026-03-07 23:22:15
