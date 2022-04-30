
require 'terminal-table'

module MAC

  def self.list
    route_ip = self.route_ip
    rows = `ip n`.split("\n")

    list = []
    rows.each do |row|
      items = row.split
      ip = items[0]
      mac = items[4]
      rol = 'device'
      rol = 'gateway' if ip == route_ip

      list << { ip: ip,
                mac: mac,
                rol: rol}
    end
    list << self.localhost_info
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

  def self.localhost_info
    ip = `ip a |grep global`.split[1].split("/")[0]
    mac = `ip a|grep 'link/ether'`.split[1]
    { ip: ip, mac: mac, rol: 'localhost' }
  end

  def self.route_ip
    `ip route|grep default`.split()[2]
  end

end
