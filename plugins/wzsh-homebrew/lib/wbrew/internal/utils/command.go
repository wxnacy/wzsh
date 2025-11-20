package utils

import (
	"bufio"
	"bytes"
	"context"
	"errors"
	"fmt"
	"io"
	"os/exec"
	"strings"
	"sync"
)

// 扫描输出并实时打印
func scanOutput(ctx context.Context, reader io.Reader, prefix string) {
	scanner := bufio.NewScanner(reader)
	for scanner.Scan() {
		select {
		case <-ctx.Done(): // 上下文取消时退出
			return
		default:
			line := scanner.Text()
			fmt.Printf("[%s] %s\n", prefix, line) // 实时打印带前缀的输出
		}
	}
	if err := scanner.Err(); err != nil {
		fmt.Printf("扫描错误: %v\n", err)
	}
}

func Spawn(name string, args ...string) {
	// 1. 创建命令对象
	cmd := exec.Command(name, args...)

	// 2. 获取标准输出和错误输出管道
	stdout, err := cmd.StdoutPipe()
	if err != nil {
		panic(fmt.Errorf("创建标准输出管道失败: %w", err))
	}
	stderr, err := cmd.StderrPipe()
	if err != nil {
		panic(fmt.Errorf("创建错误输出管道失败: %w", err))
	}

	// 3. 创建同步等待组
	var wg sync.WaitGroup
	wg.Add(2) // 等待两个输出管道处理完成

	// 4. 启动协程处理输出
	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()

	// 处理标准输出
	go func() {
		defer wg.Done()
		scanOutput(ctx, stdout, "STDOUT")
	}()

	// 处理错误输出
	go func() {
		defer wg.Done()
		scanOutput(ctx, stderr, "STDERR")
	}()

	// 5. 启动命令
	if err := cmd.Start(); err != nil {
		panic(fmt.Errorf("启动命令失败: %w", err))
	}

	// 6. 等待输出处理完成
	wg.Wait()

	// 7. 等待命令执行完成
	if err := cmd.Wait(); err != nil {
		// panic(fmt.Errorf("命令执行错误: %w", err))
		fmt.Println(err)
	}
}

func Command(name string, args ...string) (string, error) {
	c := exec.Command(name, args...)
	var out bytes.Buffer
	var outErr bytes.Buffer
	c.Stdout = &out
	c.Stderr = &outErr
	err := c.Run()
	if err != nil {
		return "", err
	}
	outStr := out.String()
	if outStr != "" {
		outStr = strings.Trim(outStr, "\n")
		return outStr, nil
	}
	outErrStr := outErr.String()
	if outErrStr != "" {
		outErrStr = strings.Trim(outErrStr, "\n")
		return "", errors.New(outErrStr)
	}
	return "", nil
}
