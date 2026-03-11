require "colorize"

class Exercise
  attr_reader :filename

  def initialize(filename)
    @filename = filename
    @content = File.read(@filename)
    find_done
    find_todo
  end

  def done?
    @done
  end

  def call
    puts "\n" + "_" * 50
    puts "=> Exercise: #{filename}\n".colorize(:white)
    syntax_ok = system("ruby -c #{filename}")
    if syntax_ok
      puts "\n=> Output:".colorize(:white)
      exec_ok = system("ruby #{filename}")
    end

    unless @todo.size.zero?
      lines = @content.split("\n")
      puts "\n=> TODO lines:".colorize(:white)
      @todo.each do |index|
        puts ("%02d | %s" % [index + 1, lines[index]]).colorize(:cyan)
      end
    else syntax_ok and exec_ok
      puts "\n=> Delete 'I AM NOT DONE' to continue!".colorize(:cyan)
    end
  end

  private

  def find_done
    filter = /# I AM NOT DONE/
    @done = false
    @done = true if @content.match(filter).nil?
  end

  def find_todo
    @todo = []
    lines = @content.split("\n")
    lines.each_with_index do |line, index|
      @todo << index if line.include? "# TODO:"
    end
  end
end
