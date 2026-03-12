#!/usr/bin/ruby
#File: update_host.rb

@debug=false

=begin
Los equipos seben permanecer actualizados, per es una lata hacerlo manualmente.
Se decide automatizarlo con este script, pero para no colapsar la red
se organiza de forma que no todos los equipos se actualizan el mismo día.

Según la IP se decide el día de la semana que se actualizarán.

=end
def update
	puts "\n[INFO] Updating this host..."
		
	r = IO.popen("hostname -I| cut -f 3 -d .").readlines
	ip3=r[0].to_i

	r = IO.popen("hostname -I| cut -f 4 -d .").readlines
	ip4=r[0].to_i

	r = IO.popen("date +%u").readlines
	daynumber=r[0].to_i
	
	flag=false		
	flag=true if (ip3==2 and daynumber==1)
	flag=true if (ip3==8 and daynumber==(ip4%4 + 2))
	flag=true if (ip3==9 and daynumber==(ip4%4 + 2))
	
	if flag then
		execute("apt-get update")
		execute("apt-get upgrade -y")
	else
		puts("[INFO] I can't update today!")
	end
end

def execute(lsCommand)
	puts "(*) Executing: #{lsCommand}"
	system(lsCommand) if !@debug
end
		
update

