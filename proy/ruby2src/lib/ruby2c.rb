require 'parser/current'

class Ruby2C
  def initialize
    @vars = {}
    @body = []
  end

  def call(ruby_source_code)
    ast = Parser::CurrentRuby.parse(ruby_source_code)
    walk(ast)
    generate_c_code
  end

  private

  def walk(node, indent = "    ")
    return unless node.is_a?(Parser::AST::Node)

    case node.type
    when :begin
      node.children.each { |child| walk(child, indent) }

    when :lvasgn # Asignación: contador = 0
      var_name = node.children[0].to_s
      value_node = node.children[1]
      
      type = (value_node.type == :str) ? "char* " : "int "
      @vars[var_name] = type unless @vars.key?(var_name)
      @body << "#{indent}#{var_name} = #{format_value(value_node)};"

    when :send # Llamada a métodos
      receiver, method, *args = node.children
      
      if method == :puts
        args.each do |arg|
          fmt = (arg.type == :str || (arg.type == :lvar && @vars[arg.children[0].to_s] == "char* ")) ? "%s" : "%d"
          @body << "#{indent}printf(\"#{fmt}\\n\", #{format_value(arg)});"
        end
      end

    when :while # BUCLE WHILE
      cond, body = node.children
      @body << "#{indent}while (#{format_value(cond)}) {"
      walk(body, indent + "    ")
      @body << "#{indent}}"

    when :if # Estructura IF
      cond, t_body, f_body = node.children
      @body << "#{indent}if (#{format_value(cond)}) {"
      walk(t_body, indent + "    ")
      @body << "#{indent}}"
      if f_body
        @body << "#{indent}else {"
        walk(f_body, indent + "    ")
        @body << "#{indent}}"
      end
    end
  end

  def format_value(node)
    return "0" unless node
    case node.type
    when :int, :float then node.children[0].to_s
    when :str         then "\"#{node.children[0]}\""
    when :lvar        then node.children[0].to_s
    when :send        # Operaciones y comparaciones (x < 10, x + 1)
      left = format_value(node.children[0])
      op = node.children[1].to_s
      right = format_value(node.children[2])
      "#{left} #{op} #{right}"
    end
  end

  def generate_c_code
    c_code = ["#include <stdio.h>\n", "int main() {"]
    @vars.each { |name, type| c_code << "    #{type}#{name};" }
    c_code += @body
    c_code << "    return 0;"
    c_code << "}"
    c_code.join("\n")
  end
end
