package model

// 顶层结构：统一包含 Formula 或 Cask 信息（二选一）
type Info struct {
	Formulae []FormulaInfo `json:"formulae,omitempty"` // 若为命令行工具（Formula），则非空
	Casks    []CaskInfo    `json:"casks,omitempty"`    // 若为图形化应用（Cask），则非空
}

func (m Info) IsCask() bool {
	return len(m.Casks) > 0
}

func (m Info) IsFormula() bool {
	return len(m.Formulae) > 0
}

func (m Info) IsInstalled() bool {
	if m.IsFormula() {
		return len(m.Formulae[0].Installed) > 0
	} else {
		return m.Casks[0].InstalledTime != nil
	}
}

func (m Info) GetAppPath() string {
	if m.IsCask() {
		for _, artifact := range m.Casks[0].Artifacts {
			if len(artifact.App) == 0 {
				return ""
			}
			name := artifact.App[0].(string)
			for _, app := range artifact.App {
				switch app.(type) {
				case CaskApp:
					name = app.(CaskApp).Target
				}
			}
			return "/Applications/" + name
		}
	}
	return ""
}
