/*
Copyright © 2025 NAME HERE <EMAIL ADDRESS>
*/
package cmd

import (
	"fmt"
	"wbrew/internal/brew"

	"github.com/spf13/cobra"
)

var reqFile string

// bundleCmd represents the bundle command
var bundleCmd = &cobra.Command{
	Use:   "bundle",
	Short: "",
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println("bundle called")
	},
}

// bundleCmd represents the bundle command
var bundleInstallCmd = &cobra.Command{
	Use:   "install",
	Short: "",
	Run: func(cmd *cobra.Command, args []string) {
		names, err := brew.BundleList(reqFile)
		if reqIsVerbose {
			fmt.Printf("Brewfile: %s\n", reqFile)
			fmt.Printf("Brewfile names %v\n", names)
		}
		if err != nil {
			fmt.Println(err)
			return
		}
		install(names)
	},
}

func init() {
	bundleCmd.AddCommand(bundleInstallCmd)
	bundleCmd.PersistentFlags().StringVarP(&reqFile, "file", "", "", "Brewfile 地址")
	rootCmd.AddCommand(bundleCmd)
}
