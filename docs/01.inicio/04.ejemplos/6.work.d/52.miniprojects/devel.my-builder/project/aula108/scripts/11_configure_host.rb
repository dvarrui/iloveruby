#!/usr/bin/ruby
#File: configure_host.rb

@default_dnsname='fpinf'
@default_dnsdomain='puerto'
#@debug=true

def configure
	puts "\n[INFO] Configuring hostname..."
		
	r = IO.popen("hostname -I").readlines
	@ip=r[0].to_s
	puts "(*) IP=#{@ip}"
	
	r = IO.popen("host #{@ip}").readlines
	begin
		n=r[0].split(' ')[4]
		i=n.split('.')
		@dnsname=i[0]
		@dnsdomain=i[1]
	rescue
		@dnsname=@default_dnsname
	end
	
	lsCommand="echo \"#{@dnsname}.#{@dnsdomain}\" > /etc/hostname"
	puts "(*) Executing: #{lsCommand}"
	system(lsCommand) if !@debug

	r = IO.popen("cat /etc/hosts|grep 127.0.1.2| wc -l").readlines
	if r[0].to_i==0 then
		lsCommand="echo \"127.0.1.2   #{@dnsname}.#{@dnsdomain}   #{@dnsname}\" >> /etc/hosts"
		puts "(*) Executing: #{lsCommand}"
		system(lsCommand) if !@debug
	else
		#replace file
		f1=File.open("/etc/hosts","r").readlines
		search="127.0.1.2"
		replace="127.0.1.2   #{@dnsname}.#{@dnsdomain}   #{@dnsname}"
		f2=File.open("/etc/hosts.new","w")
		f1.each do |i|
			if i[search]==search then
				f2.write replace
			else
				f2.write i
			end
		end
		f2.close
		system("mv /etc/hosts /etc/hosts.000")
		system("mv /etc/hosts.new /etc/hosts")
	end
	
end

configure

