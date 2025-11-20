package model

import "time"

// -------------- Formula 结构体（命令行工具）--------------
type FormulaInfo struct {
	Name      string             `json:"name"`      // 包名称（短名）
	FullName  string             `json:"full_name"` // 完整名称（含tap，如"homebrew/core/git"）
	Desc      string             `json:"desc"`      // 描述
	Homepage  string             `json:"homepage"`  // 主页URL
	Versions  FormulaVersions    `json:"versions"`  // 版本信息
	Installed []FormulaInstalled `json:"installed"` // 已安装版本
	// Dependencies []Dependency       `json:"dependencies"` // 运行依赖
	// BuildDependencies []Dependency       `json:"build_dependencies"` // 构建依赖
	Requirements []Requirement     `json:"requirements"`  // 系统需求（如macOS版本）
	Options      []FormulaOption   `json:"options"`       // 安装选项
	Bottle       *FormulaBottle    `json:"bottle"`        // 预编译包信息
	Cellar       string            `json:"cellar"`        // Cellar路径标识（如":any_skip_relocation"）
	License      string            `json:"license"`       // 许可证
	Urls         FormulaUrls       `json:"urls"`          // 源码包URL及校验值
	Artifacts    []FormulaArtifact `json:"artifacts"`     // 安装产物（二进制、服务等）
	LinkedKeg    *string           `json:"linked_keg"`    // 当前链接版本
	LastModified *time.Time        `json:"last_modified"` // 最后更新时间
	Caveats      string            `json:"caveats"`       // 注意事项
	Analytics    map[string]string `json:"analytics"`     // 安装统计
}

// Formula 版本信息
type FormulaVersions struct {
	Stable    string `json:"stable"`     // 稳定版版本号
	Head      string `json:"head"`       // 开发版标识（如"HEAD-abc123"）
	Devel     string `json:"devel"`      // 开发版版本（可选）
	StableURL string `json:"stable_url"` // 稳定版源码URL
	HeadURL   string `json:"head_url"`   // 开发版仓库URL
}

// Formula 已安装版本详情
type FormulaInstalled struct {
	Version     string   `json:"version"`      // 版本号
	Cellar      string   `json:"cellar"`       // 安装路径（如"/opt/homebrew/Cellar/git/2.45.1"）
	Prefix      string   `json:"prefix"`       // 链接路径（如"/opt/homebrew/opt/git"）
	BuiltAs     string   `json:"built_as"`     // 构建架构（如"arm64_sonoma"）
	InstalledAs string   `json:"installed_as"` // 安装时名称
	Options     []string `json:"options"`      // 安装选项
}

// Formula 安装选项
type FormulaOption struct {
	Option      string `json:"option"`      // 选项标识（如"--with-x11"）
	Description string `json:"description"` // 选项描述
}

// Formula 预编译包信息
type FormulaBottle struct {
	Stable  FormulaBottleVersion  `json:"stable"`   // 稳定版预编译包
	Devel   *FormulaBottleVersion `json:"devel"`    // 开发版预编译包（可选）
	RootURL string                `json:"root_url"` // 预编译包根URL
}

// Formula 预编译包版本详情
type FormulaBottleVersion struct {
	Revision int                   `json:"revision"` // 修订号
	Files    map[string]BottleFile `json:"files"`    // 不同系统的预编译包（key为系统标识）
	Checksum string                `json:"checksum"` // 校验值类型（如"sha256"）
}

// 预编译包文件信息（通用）
type BottleFile struct {
	URL    string `json:"url"`    // 下载URL
	Sha256 string `json:"sha256"` // SHA256校验值
}

// Formula 源码包URL信息
type FormulaUrls struct {
	Stable FormulaUrlInfo `json:"stable"` // 稳定版源码
	Head   FormulaUrlInfo `json:"head"`   // 开发版源码
}

// Formula 单个URL详情
type FormulaUrlInfo struct {
	URL      string `json:"url"`      // 下载URL
	Sha256   string `json:"sha256"`   // SHA256校验值
	Revision string `json:"revision"` // 修订号（可选）
}

// Formula 安装产物
type FormulaArtifact struct {
	Path string `json:"path"` // 产物路径（如"bin/git"）
	Type string `json:"type"` // 产物类型（如"binary"、"service"）
}
