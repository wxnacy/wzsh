package brew

import (
	"encoding/json"
	"fmt"
	"os"
	"strings"
	"wbrew/internal/model"
	"wbrew/internal/utils"
)

func List() ([]string, error) {
	// 设置环境变量
	text, err := brew("list", "--full-name", "-1")
	if err != nil {
		return nil, err
	}
	return strings.Split(text, "\n"), nil
}

func Info(name string, reqIsVerbose bool) (*model.Info, error) {
	jsonStr, err := brew("info", name, "--json=v2")
	if err != nil {
		return nil, err
	}
	if reqIsVerbose {
		fmt.Println(jsonStr)
	}

	// 定义用于 JSON 解析的结构体
	var info model.Info

	if err := json.Unmarshal([]byte(jsonStr), &info); err != nil {
		return nil, fmt.Errorf("解析 brew info json 失败: %w", err)
	}
	return &info, nil
}

func BundleList(file string) ([]string, error) {
	// 设置环境变量
	text, err := brew("bundle", "list", "--file", file)
	if err != nil {
		return nil, err
	}
	return strings.Split(text, "\n"), nil
}

func brew(args ...string) (string, error) {
	// 设置环境变量
	oldHomebrewNoAutoUpdate := os.Getenv("HOMEBREW_NO_AUTO_UPDATE")
	os.Setenv("HOMEBREW_NO_AUTO_UPDATE", "1")
	defer func() {
		// 恢复原来的环境变量设置
		if oldHomebrewNoAutoUpdate == "" {
			os.Unsetenv("HOMEBREW_NO_AUTO_UPDATE")
		} else {
			os.Setenv("HOMEBREW_NO_AUTO_UPDATE", oldHomebrewNoAutoUpdate)
		}
	}()

	return utils.Command("brew", args...)
}
