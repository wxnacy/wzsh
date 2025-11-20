package model

// -------------- Cask 结构体（图形化应用）--------------
type CaskInfo struct {
	Token             string                 `json:"token"`               // 应用token（短名）
	FullToken         string                 `json:"full_token"`          // 完整token
	OldTokens         []string               `json:"old_tokens"`          // 旧的token列表
	Tap               string                 `json:"tap"`                 // tap源
	Name              []string               `json:"name"`                // 应用名称列表
	Desc              string                 `json:"desc"`                // 描述
	Homepage          string                 `json:"homepage"`            // 主页URL
	URL               string                 `json:"url"`                 // 下载URL
	URLSpecs          map[string]interface{} `json:"url_specs"`           // URL规格
	Version           string                 `json:"version"`             // 版本号
	Autobump          bool                   `json:"autobump"`            // 是否自动更新
	NoAutobumpMessage interface{}            `json:"no_autobump_message"` // 自动更新消息
	SkipLivecheck     bool                   `json:"skip_livecheck"`      // 是否跳过实时检查
	// Installed             []CaskInstalled  `json:"installed"`             // 已安装版本
	InstalledTime                 interface{}            `json:"installed_time"`                  // 安装时间
	BundleVersion                 string                 `json:"bundle_version"`                  // 包版本
	BundleShortVersion            string                 `json:"bundle_short_version"`            // 包短版本
	Outdated                      bool                   `json:"outdated"`                        // 是否过时
	SHA256                        string                 `json:"sha256"`                          // 校验值
	Artifacts                     []CaskArtifact         `json:"artifacts"`                       // 安装产物
	Caveats                       interface{}            `json:"caveats"`                         // 注意事项
	DependsOn                     map[string]interface{} `json:"depends_on"`                      // 依赖
	ConflictsWith                 interface{}            `json:"conflicts_with"`                  // 冲突
	Container                     interface{}            `json:"container"`                       // 容器信息
	Rename                        []string               `json:"rename"`                          // 重命名
	AutoUpdates                   bool                   `json:"auto_updates"`                    // 是否支持自动更新
	Deprecated                    bool                   `json:"deprecated"`                      // 是否已弃用
	DeprecationDate               interface{}            `json:"deprecation_date"`                // 弃用日期
	DeprecationReason             interface{}            `json:"deprecation_reason"`              // 弃用原因
	DeprecationReplacementFormula interface{}            `json:"deprecation_replacement_formula"` // 弃用替换formula
	DeprecationReplacementCask    interface{}            `json:"deprecation_replacement_cask"`    // 弃用替换cask
	Disabled                      bool                   `json:"disabled"`                        // 是否已禁用
	DisableDate                   interface{}            `json:"disable_date"`                    // 禁用日期
	DisableReason                 interface{}            `json:"disable_reason"`                  // 禁用原因
	DisableReplacementFormula     interface{}            `json:"disable_replacement_formula"`     // 禁用替换formula
	DisableReplacementCask        interface{}            `json:"disable_replacement_cask"`        // 禁用替换cask
	TapGitHead                    string                 `json:"tap_git_head"`                    // tap git head
	Languages                     []string               `json:"languages"`                       // 语言
	RubySourcePath                string                 `json:"ruby_source_path"`                // Ruby源码路径
	RubySourceChecksum            map[string]string      `json:"ruby_source_checksum"`            // Ruby源码校验
}

// Cask 版本信息
type CaskVersions struct {
	Stable string `json:"stable"` // 稳定版版本号
	Latest string `json:"latest"` // 最新版标识（可能与stable一致）
	URL    string `json:"url"`    // 安装包下载URL
}

// Cask 已安装版本详情
type CaskInstalled struct {
	Version string `json:"version"`  // 版本号
	Path    string `json:"path"`     // 安装路径（如"/Applications/Google Chrome.app"）
	BuiltAs string `json:"built_as"` // 适用架构（如"arm64"）
}

// Cask 依赖项（依赖其他Cask或Formula）
type CaskDependency struct {
	Type string `json:"type"` // 依赖类型（如"cask"、"formula"）
	Name string `json:"name"` // 依赖名称（如"xquartz"）
}

// Cask 安装产物（.app、字体等）
type CaskArtifact struct {
	App []interface{} `json:"app,omitempty"` // 应用路径（如["Google Chrome.app"]）
	// Zap []CaskZapInfo `json:"zap,omitempty"` // 卸载清理项
}

type CaskApp struct {
	Target string `json:"target"`
}

// Cask 卸载清理项信息（包含 launchctl、trash、rmdir 等）
type CaskZapInfo struct {
	Launchctl []string `json:"launchctl,omitempty"` // launchctl 服务列表
	Trash     []string `json:"trash,omitempty"`     // 需要删除的文件/目录
	Rmdir     []string `json:"rmdir,omitempty"`     // 需要删除的空目录
}

// Cask 下载包容器信息（如dmg/zip的解压配置）
type CaskContainer struct {
	Type    string               `json:"type"`    // 容器类型（如"dmg"、"zip"）
	Entries []CaskContainerEntry `json:"entries"` // 容器内文件条目
}

// Cask 容器内文件条目（指定需要安装的文件）
type CaskContainerEntry struct {
	Path string `json:"path"` // 容器内路径（如"/Google Chrome.app"）
}

// Cask 签名信息（验证开发者身份）
type CaskSignature struct {
	DeveloperID string `json:"developer_id"` // 开发者ID（如"Google Inc."）
	TeamID      string `json:"team_id"`      // 开发团队ID（如"EQHXZ8M8AV"）
}

// Cask 卸载清理项（删除配置文件等）
type CaskZap struct {
	Path  string `json:"path"`  // 清理路径（如"~/Library/Application Support/Google/Chrome"）
	Type  string `json:"type"`  // 清理类型（如"file"、"directory"）
	Force bool   `json:"force"` // 是否强制清理
}

// -------------- 通用结构体（Formula和Cask共用）--------------
// 依赖项基本信息（Formula的依赖更复杂，Cask的依赖在CaskDependency中）
type Dependency struct {
	Name         string        `json:"name"`         // 依赖包名称
	Requirements []Requirement `json:"requirements"` // 版本要求（如">= 1.0"）
	Optional     bool          `json:"optional"`     // 是否为可选依赖
}

// 系统/环境需求（如macOS版本、架构）
type Requirement struct {
	Type        string `json:"type"`        // 需求类型（如"os"、"arch"）
	Minimum     string `json:"minimum"`     // 最低版本
	Maximum     string `json:"maximum"`     // 最高版本（可选）
	Recommended string `json:"recommended"` // 推荐版本（可选）
}
