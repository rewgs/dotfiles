package debian

import (
	"log"
	"os/exec"
)

var aptPackages = []string{
	"apache2",
	"apt-file",
	"apt-transport-https",
	"arp-scan",
	"automake",
	"bettercap",
	"bpytop",
	"btop",
	"build-essential",
	"cbonsai",
	"cmake",
	"cmatrix",
	"cowsay",
	"curl",
	"docker",
	"docker-compose",
	"fzf",
	"gh",
	"git",
	"glances",
	"gnupg2",
	"golang-go",
	"hsetroot",
	"htop",
	"lf",
	"libvirt-daemon",
	"llvm",
	"lua5.4",
	"lynx",
	"make",
	"ncat",
	"ncdu",
	"neofetch",
	"net-tools",
	"nmap",
	"picom",
	"qemu-kvm",
	"rename",
	"ripgrep",
	"shellcheck",
	"software-properties-common",
	"tgt",
	"thefuck",
	"tldr",
	"tree",
	"unzip",
	"vim",
	"wl-clipboard",
	"wget",
	"zip",
	"zsh",
}

func getSudo() string {
	sudo, err := exec.LookPath("sudo")
	if err != nil {
		log.Fatal(err)
	}
	return sudo
}

func getApt() string {
	apt, err := exec.LookPath("apt")
	if err != nil {
		log.Fatal(err)
	}
	return apt
}

func installAptPackages() {
	sudo := getSudo()
	apt := getApt()

	update := exec.Command(sudo, apt, "update")
	if err := update.Run(); err != nil {
		log.Fatal(err)
	}

	for _, pkg := range aptPackages {
		install := exec.Command(sudo, apt, "install", "-y", pkg)
		err := install.Run()
		if err != nil {
			log.Fatal(err)
		}
	}
}
