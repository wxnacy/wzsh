## PRODUCT

文档涉及功能都是 `bin/wzsh` 脚本相关


## TODO

- [x] `zshenv` 中 _wzsh_config_local=${WZSH_HOME}/config.local.json 替换为 `~/.config/wzsh/config.json` ✅ 2026-04-14 15:09:59
    - `/Users/wxnacy/.wzsh/lib/pythonx/config.py` 中也需要替换
    - 然后检查其他地方的代码或说明文档也一起改正
    - 修改内容：
      - `zshenv`：`_wzsh_config_local` 改为 `${XDG_CONFIG_HOME:-$HOME/.config}/wzsh/config.json`
      - `lib/pythonx/config.py`：`load_config` 和 `add-plugin` 子命令改用 XDG 路径，`add-plugin` 自动创建目录
      - `bin/wzsh`：`__install_plugin` 中 `local_config` 改为 XDG 路径，自动创建父目录
      - `AGENTS.md`：章节标题和说明更新为新路径

- [x] `zshenv` config.json 增加是否加载的字段 ✅ 2026-04-17 12:20:07
    - `plugin` 增加 `enabled` 字段支持。是否加载，默认是 true
    - 解决方案：
      - `lib/pythonx/config.py`：`get_plugin_paths()` 过滤 `enabled: false` 的插件，`add-plugin` 子命令默认写入 `enabled: true`
      - `bin/wzsh` 无需修改，全量加载时 `enabled` 过滤已在 `config.py` 中处理
    - 修改内容：
      - `config.json`：`wzsh-self` 条目加入 `enabled: true` 示例
      - `lib/pythonx/config.py`：`get_plugin_paths()` 加入 `enabled` 过滤，`add-plugin` 默认写入 `enabled: true`
      - `AGENTS.md`：插件路径解析规则表格加入 `enabled` 字段说明
      - `README.md`：新增"插件配置"章节，说明 `enabled` 字段用法
    - 提交记录：
      - bcdef92 feat(plugin): 增加 enabled 字段支持，false 时跳过加载
