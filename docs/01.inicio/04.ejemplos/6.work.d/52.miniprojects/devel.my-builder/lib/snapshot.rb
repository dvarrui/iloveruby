
class Snapshot
	attr_accessor :tmpdir,:outfile

	def initialize
		@tmpdir='tmp'
		@outfile='snapshot.txt'
	end
	
	def do
		get_installed_packages
		get_users
	end
	
	def get_installed_packages
		list=`dpkg -l|grep 'ii '|tr -s ' ' ':'|cut -d : -f 2` 
		rows=list.split("\n")
		f=File.open(@tmpdir+'/packages.txt','w')
		f.write("---\n")
		rows.sort.each { |p| f.write("- #{p.to_s}\n") }
		f.close
	end

	def get_users
		list=`cat /etc/passwd | grep /bin/bash` 
		rows=list.split("\n")
		f=File.open(@tmpdir+'/users.txt','w')
		f.write("---\n")
		rows.sort.each do |r|
			cols=r.split(':')
			f.write("- :name: #{cols[0].to_s}\n") 
			f.write("  :home: #{cols[5].to_s}\n")
			#passwd=`cat /etc/shadow|grep #{username}` 
			f.write("  :passwd: #{cols[1].to_s}\n") 
			f.write("  :uid: #{cols[3].to_s}\n") 
			f.write("  :othergroups: \n") 
		end
		f.close
	end
end
