## PLAN

- 先讨论，现在我的插件是通过 `zshenv` 中 `WZSH_PLUGINS` 列表来加载的。每个插件都有配套的 `zprofile` `zshenv` `zshrc`，并在对应文件加载他们。但是现在有个问题，内置插件在 `plugins` 中，所有的加载和创建逻辑，都是这样的。我想要加载本地任意位置的插件，和从 github 上下载到 `WZSH_PLUGIN` 中的插件，怎么改一下，不用 zshenv 中做配置，而是改个 `config.json` 之类的。帮我想一下
- 先说配置。先使用 `${WZSH_HOME}/config.json` 中 `plugins` 设置插件，但是要有 `name` `path` `github` 三个字段。只有 `name` 就是内置插件，`path` 是本地、`github` 是远程，这两种如果有 `name` 则设置名称，否则使用地址中的名称作为插件名
- 现在是有 `wzsh-` 前缀，我想灰度替换掉这个逻辑，以后不要了。另外 `github` 插件，也支持 `path` 字段，如果有的时候就变成本地调试。
- 先不急。复杂的逻辑操作是使用 python 还是lua比较好。另外我希望有个 config.local.json 作为纯本地配置，和 merge `config.json` 作为最终配置，但是不加入版本控制
- 讨论。python 调用，导致在完全新加载一个 zsh 时，速度明显变慢。想想怎么优化下


## TODO

- [x] 将 `config.local.json` 加入 `.gitignore` ✅ 2026-04-02 20:27:23
- [x] 创建 `${WZSH_HOME}/config.json`，先只包含 `wzsh-self`（内置）和 `agent`（本地，`path` 指向 `/Users/wxnacy/Projects/agent/.agent`） ✅ 2026-04-02 20:27:23
- [x] 编写 `lib/pythonx/config.py`，实现以下逻辑：
  - 读取 `config.json` + `config.local.json`，merge plugins 列表（local 追加到后面）
  - 解析每个插件的实际路径：
    - 只有 `name` → `${WZSH_HOME}/plugins/<name>`
    - 有 `path` → 直接使用 path（本地插件或 github 本地调试）
    - 只有 `github` → `${WZSH_DATA}/plugins/<repo-name>`
  - 输出插件路径列表（每行一个路径） ✅ 2026-04-02 20:27:23
- [x] 改造 `zshenv`：在原有 `WZSH_PLUGINS` 循环**之前**，调用 Python 脚本构建 `WZSH_PLUGIN_PATHS` 数组，并单独遍历加载其 `bin/` 和 `zshenv` ✅ 2026-04-02 20:27:23
- [x] 改造 `zshrc`：在原有循环**之前**，遍历 `WZSH_PLUGIN_PATHS` 加载 `zshrc` ✅ 2026-04-02 20:27:23
- [x] 改造 `zprofile`：在原有循环**之前**，遍历 `WZSH_PLUGIN_PATHS` 加载 `zprofile` ✅ 2026-04-02 20:27:23
- [x] 验证 `self` 和 `agent` 两个插件加载正常后，再逐步将其他插件从 `WZSH_PLUGINS` 迁移到 `config.json` ✅ 2026-04-02 20:27:23

- [x] 新增 `config.cache` 缓存机制，优化 zsh 启动速度：
  - `lib/pythonx/config.py` 支持将解析结果写入 `${WZSH_TEMP}/config.cache`（每行一个插件路径）
  - `zshenv` 中检查缓存有效性：`config.json` 或 `config.local.json` 比缓存新时才重新生成，否则直接读缓存
  - 缓存文件命名为 `config.cache`，预留给未来其他配置项使用
  - `config.cache` 加入 `.gitignore` ✅ 2026-04-02 20:53:35
    - 功能说明：python 进程启动开销约 ~50ms，缓存后正常启动只读文件，zsh 启动时间从 ~250ms 降至 ~205ms
    - 修改内容：
      - `lib/pythonx/config.py`：解析后写入 `${WZSH_TEMP}/config.cache`
      - `zshenv`：优先读缓存，config 变动时才重新生成
      - `.gitignore`：新增 `config.cache`
    - 提交记录：
      - 59f1ebe perf(config): 新增 config.cache 缓存，优化 zsh 启动速度

