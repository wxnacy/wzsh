# wzsh-bilibili

bilibili-cli 的 zsh 包装插件，简化 B 站命令行工具的使用。

## 功能

### bb 命令

对 bilibili-cli 进行包装，自动管理 cookie 和凭证配置。

**特性：**

- 自动验证 cookie 文件
- 自动保存凭证
- 自动设置环境变量
- 简化命令调用

**使用方法：**

```bash
# 使用默认 cookie 文件（cookies.json）
bb video info BV1xx411c7mD

# 指定 cookie 文件
bb -u ~/cookies/bili.json video info BV1xx411c7mD

# 其他 bili 命令
bb user info
bb video list
```

**参数说明：**

- `-u, --user-cookie <path>` - 指定 cookie 文件路径，默认为当前目录下的 `cookies.json`

## 依赖

- [bilibili-cli](https://github.com/wxnacy/bilibili-cli) - 需要安装在 `/Users/wxnacy/Projects/bilibili-cli/.venv/bin/bili`

## 安装

此插件作为 wzsh 的一部分自动加载。
