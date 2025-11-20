/*
Copyright © 2025 NAME HERE <EMAIL ADDRESS>
*/
package cmd

import (
	"encoding/json"
	"errors"
	"fmt"
	"wbrew/internal/brew"
	"wbrew/internal/model"
	"wbrew/internal/utils"

	"github.com/gookit/goutil/dump"
	"github.com/spf13/cobra"
	"github.com/wxnacy/go-tools"
)

var reqWithCask bool

// 获取 brew info xxx --json=v2 命令返回 json 数据中 casks[0].artifacts 列表中 key=app 的对象列表的第一个值
// 使用 Commnad 执行命令
// 数据样例:
//
//	{
//	    "casks": [
//	        {
//	            "artifacts": [
//	                {
//	                    "app": [
//	                        "Warp.app"
//	                    ]
//	                }
//	            ]
//	        }
//	    ]
//	}
func GetCaskAppName(softName string) (string, error) {
	jsonStr, err := utils.Command("brew", "info", softName, "--json=v2")
	if err != nil {
		return "", err
	}

	// 定义一个可以区分 formula 和 cask 的结构体
	var info struct {
		Formulae []json.RawMessage `json:"formulae"`
		Casks    []struct {
			Artifacts []struct {
				App []string `json:"app"`
			} `json:"artifacts"`
		} `json:"casks"`
	}

	if err := json.Unmarshal([]byte(jsonStr), &info); err != nil {
		return "", fmt.Errorf("解析 brew info json 失败: %w", err)
	}

	// 检查这是一个 formula 而不是 cask
	if len(info.Formulae) > 0 && len(info.Casks) == 0 {
		return "", errors.New("这是一个 formula, 不是 cask")
	}

	// 遍历数据结构以找到 app 名称
	if len(info.Casks) > 0 {
		cask := info.Casks[0]
		for _, artifact := range cask.Artifacts {
			if len(artifact.App) > 0 {
				return artifact.App[0], nil
			}
		}
	}

	return "", errors.New("在 brew info 中未找到 cask app 名称")
}

func BrewInfo(name string) (*model.Info, error) {
	jsonStr, err := utils.Command("brew", "info", name, "--json=v2")
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

func printInstalled(name, installPath string) {
	if installPath != "" {
		fmt.Printf("✓ %s is already installed in %s\n", name, installPath)
	} else {
		fmt.Printf("✓ %s is already installed\n", name)
	}
}

func IsInstalled(name string, installedList []string) (bool, string) {
	var installPath string
	var err error
	// 1 通过 brew list 判断是否安装软件
	if tools.ArrayContainsString(installedList, name) {
		return true, ""
	}
	// 2 通过 command 查找命令是否存在
	cmdPath, err := utils.Command("command", "-v", name)
	if err == nil {
		return true, cmdPath
	}
	// 3 通过 brew info 查询软件信息
	info, err := brew.Info(name, reqIsVerbose)
	if reqIsVerbose {
		fmt.Printf("BrewInfo error: %v\n", err)
	}
	if err == nil {
		if reqIsVerbose {
			fmt.Printf("BrewInfo %#v\n", info)
			dump.Println(info)
			// fmt.Printf("BrewInfo installed_time %v", info.Casks)
		}

		if info.IsCask() {
			if reqIsVerbose {
				fmt.Printf("Checking App %s\n", info.GetAppPath())
			}
			if tools.DirExists(info.GetAppPath()) {
				installPath = info.GetAppPath()
			}
			if info.IsInstalled() || installPath != "" {
				return true, installPath
			}
		} else {
			// Formulae
			if info.IsInstalled() {
				return true, installPath
			}
		}
	}
	return false, ""
}

func install(names []string) {
	installedList, err := brew.List()
	if err != nil {
		if reqIsVerbose {
			fmt.Println(err)
			installedList = make([]string, 0)
		}
	}
	for _, name := range names {

		isInstalled, installedPath := IsInstalled(name, installedList)
		if isInstalled {
			printInstalled(name, installedPath)
			continue
		}

		// 执行安装
		fmt.Printf("Installing %s...\n", name)
		utils.Spawn("brew", "install", name)
	}
}

// installCmd represents the install command
var installCmd = &cobra.Command{
	Use:   "install",
	Short: "快速安装命令",
	Long:  `对于 homebrew 来说，如果软件已存在 install 命令耗时太长，会做很多没有必要的事情，当前命令就是尽量减少这些操作耗时`,
	Run: func(cmd *cobra.Command, args []string) {
		if reqIsVerbose {
			fmt.Printf("args %#v\n", args)
		}
		install(args)
	},
}

func init() {
	installCmd.PersistentFlags().BoolVarP(&reqWithCask, "cask", "", false, "是否使用 cask")
	rootCmd.AddCommand(installCmd)
}
