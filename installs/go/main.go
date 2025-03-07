package main

import (
	"log"
	"runtime"

	"github.com/rewgs/dotfiles/installs/go/internal/darwin"
	"github.com/rewgs/dotfiles/installs/go/internal/linux"
	"github.com/rewgs/dotfiles/installs/go/internal/windows"
)

func main() {
	switch os := runtime.GOOS; os {
	case "darwin":
		darwin.Setup()
	case "linux":
		linux.Setup()
	case "windows":
		windows.Setup()
	default:
		log.Fatalf("Unsupported OS: %s\n", os)
	}
}
