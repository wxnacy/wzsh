## PLAN


## TODO

- [x] `zshrc` `zshenv` `zprofile` 中去掉对 `.local` 的加载 ✅ 2026-04-03 15:14:35
    - 提交记录：
      - 8ec6f84 refactor: 移除 zshenv/zshrc/zprofile 中对 .local 文件的加载逻辑
- [x] `zshrc` 中加载插件时也要加载 `aliases.zsh`，在 `zshrc` 之前加载 ✅ 2026-04-03 15:25:32
    - 功能说明：主循环统一先 source aliases.zsh 再 source zshrc，同时移除各插件 zshrc 里的重复 source 行
    - 提交记录：
      - 2ae883a refactor(zshrc): 统一在主循环加载 aliases.zsh，移除各插件 zshrc 中的重复 source
- [x] `bin/wzsh` 中 `plugin load` 方法，增加参数 `--brew` 只执行 Brewfile ✅ 2026-04-03 21:02:26
    - 修改内容：`__load_one` 新增 mode 参数（full/no_brew/brew_only），`--brew` 传入 brew_only 只执行 Brewfile
    - 提交记录：
      - 34a1a88 feat(wzsh): plugin load 新增 --brew 参数，只执行 Brewfile；修复 WZSH_HOME export
