package arch

import (
	"log"
	"os/exec"
)

var pacmanPackages = []string{
	// NOTE: Commented-out packages are incorrect package names.
	"apache",
	"arp-scan",
	"automake",
	"base-devel", // equivalent to apt's built-essential
	"bettercap",
	"bpytop",
	"brightnessctl", // for using media keys to control brightness
	"btop",
	"cmake",
	"cmatrix",
	"cowsay",
	"curl",
	"discord",
	"docker",
	"docker-compose",
	"element-desktop",
	"fastfetch",
	"feh", // image viewer
	"firefox",
	"flatpak",
	"foot",
	"fuzzel",
	"fwupd", // great utility for updating/managing hardware firmware
	"fzf",
	"git",
	"github-cli",
	"glances",
	// "gnu-ncat",
	"gnupg",
	"go",
	"hsetroot",
	"htop",
	"lf",
	"libvirt",
	"llvm",
	"lua",
	"luarocks",
	"lynx",
	"make",
	"ncdu",
	"neofetch",
	"net-tools",
	"networkmanager", // nmcli, nmtui
	"nmap",
	"nnn",      // cli file manager
	"nwg-look", // GTK settings manager for wayland environments
	"obsidian",
	"openvpn", // required for ProtonVPN
	"pass",
	"pavucontrol", // for controlling volume via media keys
	"picom",
	"podman",
	"qemu-full",
	"qt6-base",
	"qtcreator",
	// AMAZING package -- finds the fastest `n` mirrors for pacman.
	// Be sure to integrate with systemd:
	// `sudo systemctl enable reflector.timer`
	// `sudo systemctl start reflector.timer`
	"reflector",
	"ranger", // cli file manager
	"ripgrep",
	"samba",
	"shellcheck", // not available for ARM
	"signal-desktop",
	"sshfs",
	"sxiv",      // image viewer
	"tailscale", // run `sudo systemctl enable --now tailscaled` to start, and then `sudo tailscale up` and `sudo tailscale up --ssh`
	// "tgt",
	"thefuck",
	"thunderbird",
	"tldr",
	"tree",
	"unzip",
	"vifm", // cli file manager
	"vim",
	"wireguard-tools", // required for ProtonVPN
	"wl-clipboard",    // dead simple clipboard utility for Wayland-based window managers; https://github.com/bugaevc/wl-clipboard
	"wget",
	"zip",
	"zsh",
}

func installPacmanPackages() {
	pacman, err := exec.LookPath("pacman")
	if err != nil {
		log.Fatal(err)
	}

	for _, pkg := range pacmanPackages {
		cmd := exec.Command(pacman, "-Syu", "--needed", "--noconfirm", pkg)
		err := cmd.Run()
		if err != nil {
			log.Fatal(err)
		}
	}
}
