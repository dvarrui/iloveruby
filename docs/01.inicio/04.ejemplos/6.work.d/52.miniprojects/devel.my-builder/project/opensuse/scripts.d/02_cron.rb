#!/usr/bin/ruby
# encodig: utf-8

def add_to_cron
	@dirbase=File.dirname($0)+"/.."
	file=Filejoin(@dirbase, "files.d", "crontab.conf")
	system("crontab -u root #{file}")

	system("cp #{@dirbase}/scripts.d/??_configure_host.rb /etc/cron.weekly/")
	system("chown root.root /etc/cron.weekly/??_configure_host.rb")
  
# system("cp #{@dirbase}/files/update_host.rb /etc/cron.daily")
# system("chown root.root /etc/cron.daily/update_host.rb")
end

add_to_cron
