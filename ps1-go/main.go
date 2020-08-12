package main

import (
	"fmt"
	"os"
	"strconv"
	"strings"
	"time"
)

var (
	fgReset   = fgColor(0)
	fgBlack   = fgColor(30)
	fgRed     = fgColor(31)
	fgGreen   = fgColor(32)
	fgYellow  = fgColor(33)
	fgBlue    = fgColor(34)
	fgMagenta = fgColor(35)
	fgCyan    = fgColor(36)
	fgWhite   = fgColor(37)
)

func fgColor(color int) string {
	return fmt.Sprintf("\x1b[%dm", color)
}

func timeNow() string {
	t := time.Now()
	return timeColor() + fmt.Sprintf("%02d:%02d:%02d", t.Hour(), t.Minute(), t.Second())
}

func timeColor() string {
	return fgCyan
}

func pathInfo() string {
	cwd, err := os.Getwd()
	if err != nil {
		cwd = "error"
	}
	shortwd := strings.Replace(cwd, os.Getenv("HOME"), "~", 1)
	reset := "\x1b[0m"
	return shortwd + reset
}

func statusAndPrompt() string {
	if len(os.Args) < 2 {
		return fgRed + "?"
	}
	num, err := strconv.Atoi(os.Args[1])
	if err != nil {
		num = 0
	}
	if num == 0 {
		return ""
	}
	return fgRed + os.Args[1]
}

func mode() string {
	return fgYellow + ">"
}

func pathColor() string {
	return fgYellow
}

func main() {
	fmt.Printf("%s %s%s %s%s", timeNow(), pathColor()+pathInfo(), gitInfo(), statusAndPrompt(), fgReset)
}
