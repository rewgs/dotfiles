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

##
# @param dir [String] the directory to search for a matching subdirectory.
# @returns [Boolean, String|nil] whether a matching directory was found, and the path if so.
def find_matching_dir(dir)
  Dir.each_child(dir) do |child|
    # puts "Checking child: #{child}"
    if child == Socket.gethostname
      # puts "Found matching directory for hostname: #{child}"
      return true, File.join(dir, child)
    end
  end
  # puts "No matching directory found for hostname: #{Socket.gethostname}"
  return false, nil
end

def main
  this_file = File.expand_path(File.dirname(__FILE__))
  # puts "This file is located at: #{this_file}"

  dots_dir = File.join(this_file, 'dots')
  # puts "Dots directory is located at: #{dots_dir}"

  found, dir = find_matching_dir(dots_dir)
  if found
    puts "Found matching dotfiles directory for this machine: #{dir}"
  else
    puts "No matching dotfiles directory found for this machine (hostname: #{Socket.gethostname})."
    puts "Please choose one of the following options:"
    puts "1) Use a pre-existing dotfiles directory."
    puts "2) Copy a pre-existing dotfiles directory for this machine."

    print "Enter your choice (1 or 2): "
  end
end

main
