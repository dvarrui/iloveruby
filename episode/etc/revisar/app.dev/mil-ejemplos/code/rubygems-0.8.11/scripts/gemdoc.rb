#!/usr/bin/env ruby
#---
# Excerpted from "Everyday Scripting in Ruby"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/bmsft for more book information.
#---

require 'rubygems'
Gem.manage_gems
require 'rubygems/user_interaction'

include Gem::DefaultUserInteraction

$gm = Gem::CommandManager.instance

class CaptureSay
  attr_reader :string
  def initialize
    @string = ''
  end
  def say(msg)
    @string << msg << "\n"
  end
end

def pre(cmd, opts)
  puts "<pre>"
  cmd.invoke opts
  puts "</pre>"
end

def table_of_contents
  cs = CaptureSay.new
  use_ui(cs) do
    $gm['help'].invoke 'commands'
  end
    # We're only interested in the lines that actually describe a command.
  out = cs.string.grep(/^\s+(\w+)\s+(.*)$/).join("\n")
    # Add a link to the relevant section in the margin.
  out.gsub(/^\s+(\w+)/) {
    cmd_name = $1
    "  [http://rubygems.rubyforge.org/wiki/wiki.pl?GemReference##{cmd_name} -]  #{cmd_name}"
  }
end

while line = gets
  if line =~ /^!/
    cmd, arg = line.split
    case cmd
    when "!usage"
      begin
	cmdobj = $gm[arg]
	pre(cmdobj, "--help")
      rescue NoMethodError
	puts "Usage of command #{arg} failed"
      end
    when "!toc"
      puts table_of_contents()
    when "!toc-link"
      puts "\"Table of Contents\":http://docs.rubygems.org/read/chapter/10#toc"
    when "!version"
      puts Gem::RubyGemsPackageVersion
    end
  else
    puts line
  end
end
