## PRODUCT

文档涉及功能都是 `bin/wzsh` 脚本相关


## TODO

- [x] `plugin create` 功能增加 `--dir` `-d` 参数，指定插件创建的目录。默认保持现在 dirname 的逻辑 ✅ 2026-04-25 12:53:34
    - for 循环创建文件时，先检查是否存在，已存在的，跳过并打印日志
    - 功能说明：
      - 原有实现：`__create_plugin` 第二个位置参数作为 plugin_root，无命名参数支持
      - 新增 `--dir/-d` 命名参数解析，保持默认值 `${WZSH_HOME}/plugins`
      - for 循环中对每个文件先判断 `[ -f "$dirname/$_name" ]`，已存在则打印跳过日志，不执行 touch
      - `config/help.json` 同样增加存在检查
    - 修改内容：
      - `bin/wzsh`：重写 `__create_plugin` 函数，增加参数解析和文件存在检查
      - `AGENTS.md`：新增 `plugin create` 和 `plugin init` 命令说明
      - `README.md`：方法表格新增 `wzsh plugin create` 和 `wzsh plugin init` 行
    - 提交记录：
      - 2cbcb2d feat(plugin): create 增加 --dir/-d 参数，创建文件时跳过已存在文件
- [x] 重构 `plugin init` 功能，当前目录作为插件目录执行 `plugin create` 操作 ✅ 2026-04-25 12:53:34
    - 功能说明：
      - 原有实现：执行插件目录下的 `init.zsh` 脚本
      - 新实现：获取当前目录路径，从目录名推断插件名（去掉 `wzsh-` 前缀），以父目录为 `--dir` 参数调用 `__create_plugin`
      - 已存在的文件不会被覆盖，适合在已有插件目录中补全缺失骨架文件
    - 修改内容：
      - `bin/wzsh`：重写 `__init_plugin` 函数
      - `AGENTS.md`：新增 `plugin init` 使用说明
      - `README.md`：方法表格新增 `wzsh plugin init` 行
    - 提交记录：
      - 2cbcb2d feat(plugin): create 增加 --dir/-d 参数，创建文件时跳过已存在文件
- [x] 上面需求理解有误 ✅ 2026-04-25 12:58:00
    - `plugin create` --dir 理解有误，赋值的是 `dirname` ，不是 plugin_root
    - `plugin init` 也是，当前目录 `./` 作为 `--dir` 参数
    - 功能说明：
      - `--dir/-d` 直接赋值给 `dirname`（插件目录本身），不再拼接 `wzsh-<name>`
      - `plugin init <name>` 将当前目录 `$(pwd)` 作为 `--dir` 传入 `__create_plugin`
    - 修改内容：
      - `bin/wzsh`：修正 `__create_plugin` 和 `__init_plugin` 逻辑
      - `AGENTS.md`：更新说明
    - 提交记录：
      - feat(plugin): 修正 create --dir 语义和 init 实现逻辑
