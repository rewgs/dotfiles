#!/usr/bin/env ruby
#
# Sets up a machine to use the dotfiles directory in dots dir that matches the machine's hostname.
# If no match is found, the user is prompted to either:
#   1) user a pre-existing one, or
#   2) copy a pre-existing one for the current machine.
#
# The "common" directory contains files that are common to all machines' configs.
#
# Machines with multiple states, such as "laptop" and "docked," may also have a "common" directory,
# which contains files that are common to all states of that machine, but only that machine.

require 'socket'

# class Machine
#   def initialize
#   end
# end

def main
  directories = Dir.glob('./dots/*/')
  directories.each do |dir|
    if dir.basename == Socket.gethostname
      # testing
      puts dir
    end
  end
end

main
