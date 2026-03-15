#!/usr/bin/env ruby

require "colorize"
require "debug"

module StepByStep
  def self.call(source)
    show_code(source)
    print "\n(enter)"
    gets

    scope = nil # Do not pass binding to first eval
    source.split("\n").each_with_index do |line, index|
      show_code(source, index, scope)
      begin
        puts "\n[output]".colorize(:white)
        scope = eval("#{line}; binding", scope)
      rescue NameError => e
        puts "[NameError] #{e}"
      end
      print "\n(enter)"
      gets
    end
  end

  def self.show_code(source, current = -1, scope = nil)
    system("clear")
    puts "[source code]             [variables]".colorize(:white)
    lines = source.split("\n")
    lines.each_with_index do |line, index|
      arrow = " "
      color = :white
      lvar = ""
      if index == current
        arrow = "\u{279C}"
        color = :light_white
        lvar = variables_from(scope)
      end
      str = "#{index}: #{arrow} #{line.ljust(20)} #{lvar}"
      puts str.colorize(color)
    end
  end

  def self.variables_from(scope)
    return if scope.nil?
    lvar = scope.local_variables 
    lvar = lvar - [:e, :index, :line, :scope, :source]
    output = []
    lvar.each { output << "#{_1}=#{scope.local_variable_get(_1)}" }
    output.join(",")
  end
end

source = <<~RUBY
  a = 3
  b = 4
  c = a + b
  puts c
RUBY

StepByStep.call(source)
