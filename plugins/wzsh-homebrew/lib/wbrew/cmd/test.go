/*
Copyright © 2025 NAME HERE <EMAIL ADDRESS>
*/
package cmd

import (
	"fmt"
	"wbrew/internal/brew"

	"github.com/spf13/cobra"
)

// testCmd represents the test command
var testCmd = &cobra.Command{
	Use:   "test",
	Short: "A brief description of your command",
	Long: `A longer description that spans multiple lines and likely contains examples
and usage of using your command. For example:

Cobra is a CLI library for Go that empowers applications.
This application is a tool to generate the needed files
to quickly create a Cobra application.`,
	Run: func(cmd *cobra.Command, args []string) {
		names, err := brew.BundleList("/Users/wxnacy/.wzsh/plugins/wzsh-nvim/Brewfile")
		fmt.Println(names)
		fmt.Println(err)
	},
}

func init() {
	rootCmd.AddCommand(testCmd)
}
