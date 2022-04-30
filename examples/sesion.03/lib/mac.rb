
require 'terminal-table'

module MAC

  def self.list
    rows = `ip n`.split("\n")
    # => ["192.168.1.1 dev wlp6s0 lladdr 0c:8e:29:2b:46:ee REACHABLE "]
    list = []
    rows.each do |row|
      items = row.split
      data = { ip: items[0],
               mac: items[4],
               rol: 'host'}
      list << data
    end
    list << self.local_mac
    list
  end

  def self.show_list
    list = self.list
    rows = list.map { [_1[:mac], _1[:ip], _1[:rol]] }
    table = Terminal::Table.new :headings => ['MAC', 'IP', 'Rol'], :rows => rows
    puts table
  end

  def self.find_for_ip(ip)
    #require 'debug'; binding.break
    list = self.list
    list.each do |item|
      return item if ip == item[:ip]
    end
    { ip: '?', mac: '?', rol: '?'}
  end

  def self.local_mac
    ip = `ip a |grep global`.split[1].split("/")[0]
    mac = `ip a|grep 'link/ether'`.split[1]
    { ip: ip, mac: mac, rol: 'localhost' }
  end

end
