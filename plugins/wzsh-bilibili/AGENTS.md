# wzsh-bilibili 项目结构

## 项目目录结构

```
wzsh-bilibili/
├── bin/                # 可执行脚本目录
├── config/             # 配置文件目录
├── aliases.zsh         # 别名定义
├── zshrc               # 主配置文件和函数定义
├── zshenv              # 环境变量配置
├── zprofile            # profile 配置
└── installer           # 安装脚本
```

## 路径引用规范

- 本项目文件根目录统一使用 `${WZSH_HOME}` 变量引用
- 示例：`${WZSH_HOME}/plugins/wzsh-bilibili/zshrc`

## 命令说明

### bb - bilibili-cli 包装命令

对 bilibili-cli 命令进行包装，简化 cookie 管理和凭证配置。

#### 命令参数

- `-u, --user-cookie <path>` - 指定 cookie 文件路径，默认 `cookies.json`

#### 功能说明

- 自动验证 cookie 文件存在性
- 自动提取 cookie 文件所在目录
- 自动执行 `bili credential --save` 保存凭证
- 自动设置 `BILIBILI_CREDENTIAL` 环境变量
- 将其余参数透传给 bili 命令

#### 使用示例

```bash
# 使用默认 cookie 文件
bb video info BV1xx411c7mD

# 指定 cookie 文件
bb -u ~/cookies/bili.json video info BV1xx411c7mD
```
