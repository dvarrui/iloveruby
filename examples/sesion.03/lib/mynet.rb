
require 'terminal-table'

module MyNET

  def self.mac_list
    rows = `ip n`.split("\n")
    # => ["192.168.1.1 dev wlp6s0 lladdr 0c:8e:29:2b:46:ee REACHABLE "]
    list = []
    rows.each do |row|
      items = row.split
      data = { ip: items[0],
               dev: items[2],
               mac: items[4] }
      list << data
    end
    list
  end

  def self.show_mac_list
    list = self.mac_list
    rows = list.map { [_1[:mac], _1[:ip], _1[:dev]] }
    table = Terminal::Table.new :headings => ['MAC', 'IP', 'Device'], :rows => rows
    puts table
  end
end
