#!/usr/bin/env ruby
# Analizar la estructura del AST de Ruby 
# y "traduce" cada nodo a su equivalente en BASIC.

require 'parser/current'

class Ruby2Basic
  def initialize
    @line_number = 10
    @output = []
  end

  def call(ruby_source_code)
    ast = Parser::CurrentRuby.parse(ruby_source_code)    
    process_node(ast)
    
    @output << "#{@line_number} END"
    @output.join("\n")
  end

  private

  def process_node(node)
    return unless node.is_a?(Parser::AST::Node)

    case node.type
    when :begin # Block with several lines
      node.children.each { |child| process_node(child) }

    when :lvasgn # Local var assignment: x = 10
      name = node.children[0].to_s.upcase
      value = node.children[1].children[0]
      emit "LET #{name} = #{value}"

    when :send # Method call: puts("hola") o x + y
      receiver, method, *args = node.children
      
      if method == :puts
        text = args[0].type == :str ? "\"#{args[0].children[0]}\"" : args[0].children[0].to_s.upcase
        emit "PRINT #{text}"
      elsif [:+, :-, :*, :/].include?(method)
        # Handling complex operations
        emit "TODO #{method}"
      end

    when :if # Conditional
      condition, body_true, body_false = node.children
      # Simplificado: asume comparación directa
      var = condition.children[0].children[0].to_s.upcase
      op = condition.children[1] == :== ? "=" : condicion.children[1]
      val = condition.children[2].children[0]
      
      emit "IF #{var} #{op} #{val} THEN"
      process_node(body_true)
      emit "END IF"
      
    when :block # Bucles como 5.times do ...
      send_node, args, body = node.children
      if send_node.children[1] == :times
        value_times = send_node.children[0].children[0]
        var_iter = "I" # Simplificado
        emit "FOR #{var_iter} = 1 TO #{value_times}"
        process_node(body)
        emit "NEXT #{var_iter}"
      end
    end
  end

  def emit(instruction)
    @output << "#{@line_number} #{instruction}"
    @line_number += 10
  end
end
