#!/usr/bin/env python3

import subprocess


def get_all_local_machines() -> list[str]:
    # local all_machines=$(nmap -v -sn 192.168.1.0/24)
    all_machines = subprocess.check_output(["nmap", "-v", "-sn", "192.168.1.0/24"]).decode("utf-8").splitlines()
    return all_machines


def get_online_machines(all_machines: list[str]) -> list[str]:
    OFFLINE = "[host down]"
    online_machines = []
    for machine in all_machines:
        # if OFFLINE not in machine and not any(True for x in ETC if x in machine):
        if OFFLINE not in machine and "Nmap scan report for " in machine:
            online_machines.append(machine)
    return online_machines


def main():
    print("Scanning LAN...")
    all_machines: list[str] = get_all_local_machines()
    online_machines: list[str] = get_online_machines(all_machines)
    for machine in online_machines:
        print(machine)


if __name__ == "__main__":
    main()
