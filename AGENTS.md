# wzsh 项目结构

## 项目目录结构

```
.wzsh/
├── plugins/
│   └── wzsh-self/
│       ├── bin/
│       │   └── cmd              # 命令行管理工具
│       └── docs/
│           └── todo/
│               └── cmd-v1.0.md  # 产品需求文档
├── AGENTS.md                    # 项目结构说明
└── README.md                    # 项目使用说明
```

## 命令说明

### cmd - 命令行管理工具

管理常用命令行，避免时间长忘记命令怎么使用，可以搜索并把选中的命令行输入到 shell 中。

#### 命令参数

- `-c, --config <path>` - 指定配置文件目录，默认 `~/Documents/Configs/wzsh/self`

#### 子命令

- `cmd` - 搜索并选择命令
  - 使用 fzf 展示所有命令
  - 可以按 ID、别名、命令行、描述进行筛选
  - 回车确认后将命令输入到当前 shell 输入框，等待用户手动执行
  - 按 `Ctrl-O` 直接执行命令

- `cmd add` - 添加新命令
  - 交互式输入命令行 (command)
  - 交互式输入描述 (desc)
  - 交互式输入别名 (alias)，留空自动生成 UUID
  - 自动生成唯一 ID
  - 别名和 ID 必须唯一

- `cmd edit <id|alias>` - 编辑命令
  - 可以使用 ID 或别名作为查找索引
  - 交互式修改命令行、描述和别名
  - 显示原值供参考

- `cmd rm <id|alias>` - 删除命令
  - 可以使用 ID 或别名作为查找索引
  - 删除指定命令

- `cmd run <id|alias>` - 直接运行命令
  - 可以使用 ID 或别名作为查找索引
  - 直接执行指定命令

#### 数据存储

命令数据以 JSON 格式保存在 `${config}/cmd.json` 中，结构如下：

```json
{
  "commands": [
    {
      "id": 1,
      "command": "ls -la",
      "desc": "列出所有文件详细信息",
      "alias": "ll"
    }
  ],
  "next_id": 2
}
```
