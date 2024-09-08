#!/bin/bash


get-distro::main () {
    ( lsb_release -ds || cat /etc/*release || uname -om ) 2>/dev/null | head -n1
}
get-distro::main
