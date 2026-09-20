
require 'colorize'

class Pretty

  def self.print(panel)
    puts format(panel)
  end

  def self.format(panel)
    output = []
    panel.data.each { |row| output << pretty_row(row) }
    output
  end

  def self.pretty_row(row)
    output = ''
    row.each { |col| output += pretty_col(col) }
    output
  end

  def self.pretty_col(col)
    " %2d" % col
  end
end
