package linux

import (
	"log"

	"github.com/rewgs/dotfiles/installs/go/internal/linux/arch"
	"github.com/rewgs/dotfiles/installs/go/internal/linux/debian"
	"github.com/rewgs/dotfiles/installs/go/internal/linux/rhel"
	"github.com/zcalusic/sysinfo"
)

func Setup() {
	var s sysinfo.SysInfo
	s.GetSysInfo()

	switch distro := s.OS.Vendor; distro {
	case "arch":
		arch.Setup()
	case "debian":
		debian.Setup()
	case "ubuntu":
		debian.Setup()
	case "rhel":
		rhel.Setup()
	default:
		log.Fatalf("Unsupported distro: %s\n", distro)
	}
}
