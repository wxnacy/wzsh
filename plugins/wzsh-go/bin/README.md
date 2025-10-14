# Go 版本脚本

这些脚本用于辅助管理 Go 项目的版本号。

它们会按以下顺序自动检测版本文件：
1.  `./version.go`
2.  `./cmd/version.go`
3.  `./cli/version.go`

如果未找到版本文件，脚本将报错并退出。

## 脚本

### `wzsh-go-version-file` (或 `z go version-file`)

查找并输出版本文件的路径。

### `wzsh-go-version` (或 `z go version`)

显示版本文件中的当前版本号。

### `wzsh-go-incr-version` (或 `z go incr-version`)

以交互方式增加版本号（主版本号、次版本号或修订号）。该脚本会更新版本文件，并提供提交和推送更改的选项。

### `wzsh-go-release` (或 `z go release`)

为当前版本创建并推送一个 git 标签。