## PLAN

- 讨论：wzsh 脚本。`bin/wzsh` `bin/z` `bin/wzsh-install` 我想合成一个
- 讨论：现在插件中 `bin` 内的脚本是有两套机制，一个是循环加到 `PATH`。一个是统一加到 `WZSH_BIN` 中，再加一次 `PATH`。第二种方案更好
- `z` 中 run 插件 bin 的功能，因为统一用 `WZSH_BIN` 软链方案后已无必要

## TODO

- [x] 将 `bin/wzsh`、`bin/z`、`bin/wzsh-install` 合并为统一的 `wzsh` 命令，子命令规划：
  - `wzsh update` - 更新 wzsh（原 wzsh update）
  - `wzsh plugin create <name>` - 创建插件
  - `wzsh plugin conf <name>` - 编辑插件
  - `wzsh plugin home <name>` - 输出插件目录
  - `wzsh plugin init <name>` - 初始化插件
  - `wzsh plugin install [name] [--no-brew]` - 安装插件（原 wzsh-install），详见下条
  - `wzsh plugin add-brew <name> <formula>` - 将软件添加到插件 Brewfile（原有，保留）
  - `wzsh plugin remove-brew <name> <formula>` - 从插件 Brewfile 移除软件（原有，保留）
  - 保留 `wzsh-install` 作为 `wzsh plugin install` 的 alias，向后兼容
  - 删除 `bin/z`（功能已无必要） ✅ 2026-04-02 22:14:46
    - 修改内容：
      - `bin/wzsh`：整合所有子命令
      - `bin/wzsh-install`：改为 wrapper
      - `bin/z`：删除
      - `lib/pythonx/config.py`：新增 path-of/github-of/github-list 子命令
    - 提交记录：
      - 7dac2f4 feat(wzsh): 合并 wzsh/wzsh-install/z，统一 bin 加载机制

- [x] 改造 `wzsh plugin install`，完整流程：
  - 检查 `config.local.json` 是否存在，不存在则创建并写入 `{ "plugins": [] }`
  - 读取 `config.json` + `config.local.json`，获取插件列表（复用 `config.py`）
  - 支持 `wzsh plugin install [name]`：有 name 则只安装指定插件，无 name 则安装全部
  - `config.py` 新增 `path-of <name>` 子命令，按 name 返回插件路径
  - 每个插件的安装流程（关键步骤均输出日志）：
    1. `github` 类型：检查目标目录是否存在，不存在则 `git clone`，已存在则跳过
    2. 软链 `bin/` 下可执行文件到 `WZSH_BIN`
    3. 执行 `Brewfile`（除非 `--no-brew`）
    4. 执行 `installer` ✅ 2026-04-02 22:14:46
    - 提交记录：
      - 7dac2f4 feat(wzsh): 合并 wzsh/wzsh-install/z，统一 bin 加载机制

- [x] 统一插件 bin 加载机制，去掉方案一（直接加 PATH），只保留方案二（软链到 WZSH_BIN）：
  - 移除 `zshenv` 中 `WZSH_PLUGIN_PATHS` 循环里将 bin 目录加入 PATH 的逻辑
  - 移除 `zshenv` 中旧 `WZSH_PLUGINS` 循环里将 bin 目录加入 PATH 的逻辑
  - `wzsh plugin install` 负责将插件 bin 软链到 `WZSH_BIN`
  - `WZSH_BIN` 只加一次 PATH（已在 zshenv 中） ✅ 2026-04-02 22:14:46
    - 提交记录：
      - 7dac2f4 feat(wzsh): 合并 wzsh/wzsh-install/z，统一 bin 加载机制

- [x] `bin/wzsh` 及其子命令增加 `-h` 帮助文档 ✅ 2026-04-03 09:54:46
    - 修改内容：
      - `bin/wzsh`：顶层和 `plugin` 子命令均支持 `-h`/`--help`
    - 提交记录：
      - e5d548e feat(wzsh): 新增 -h 帮助文档，wzsh 和 wzsh plugin 均支持
