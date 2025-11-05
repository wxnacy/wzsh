// 将输入的文件地址转为拼音
//
// 实现逻辑:
// - 先过滤掉字符串中的英文和特殊字符
// - 将留下的汉字转为拼音，去掉中间的空格
//
// 补充单元测试
package main

import (
	"bufio"
	"fmt"
	"os"

	"github.com/mozillazg/go-pinyin"
)

func main() {
	var text string
	if len(os.Args) > 1 {
		text = os.Args[1] // 从命令行参数获取文本
	} else {
		// 从标准输入读取
		scanner := bufio.NewScanner(os.Stdin)
		scanner.Scan()
		text = scanner.Text()
	}

	args := pinyin.NewArgs()
	args.Style = pinyin.NORMAL // 无声调模式
	pinyinList := pinyin.Pinyin(text, args)

	result := ""
	for _, words := range pinyinList {
		result += words[0] + ""
	}
	fmt.Println(result)
}
