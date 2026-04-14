## PLAN


## TODO

- [x] `zshenv` 中 _wzsh_config_local=${WZSH_HOME}/config.local.json 替换为 `~/.config/wzsh/config.json` ✅ 2026-04-14 15:09:59
    - `/Users/wxnacy/.wzsh/lib/pythonx/config.py` 中也需要替换
    - 然后检查其他地方的代码或说明文档也一起改正
    - 修改内容：
      - `zshenv`：`_wzsh_config_local` 改为 `${XDG_CONFIG_HOME:-$HOME/.config}/wzsh/config.json`
      - `lib/pythonx/config.py`：`load_config` 和 `add-plugin` 子命令改用 XDG 路径，`add-plugin` 自动创建目录
      - `bin/wzsh`：`__install_plugin` 中 `local_config` 改为 XDG 路径，自动创建父目录
      - `AGENTS.md`：章节标题和说明更新为新路径
