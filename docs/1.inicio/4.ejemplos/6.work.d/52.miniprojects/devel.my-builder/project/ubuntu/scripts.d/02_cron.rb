#!/usr/bin/ruby
# encodig: utf-8

def set_params
	d=(__FILE__).split("/")
	d.delete_at(-1)
	d.delete_at(-1)
	@dirbase=d.join("/")
end

def add_to_cron
	system("crontab -u root #{@dirbase}/files.d/crontab.conf")

  system("cp #{@dirbase}/scripts.d/??_configure_host.rb /etc/cron.weekly/")
  system("chown root.root /etc/cron.weekly/??_configure_host.rb")
  
# system("cp #{@dirbase}/files/update_host.rb /etc/cron.daily")
# system("chown root.root /etc/cron.daily/update_host.rb")
end

set_params
add_to_cron

