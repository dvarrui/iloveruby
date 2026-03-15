
require 'erb'
require 'yaml'

=begin

Permite invocar los comandos necesarios para personalizar el sistema operativo
anfitrión según se especifique en la configuración 'configname'

El método *build_system* ejecuta su tareas en los siguientes pasos:
1) load_params psOSname: carga la parametrización específica del SO.
2) install_packages: Se encarga de instalar paquetes/aplicaciones.
3) download_files: Descarga ficheros de un repositorio central.
4) configure_users: Crea usuarios y los configura
5) process_commands: Ejecuta los comandos/scripts especificados
=end

class Builder
	attr_accessor :debug, :verbose
	attr_reader :package_name
	
	def initialize
		@param={}
		@debug=false
		@verbose=true
		@logfile='tmp/default.log'
	end
	
	def build_system(psOSname)			
		Dir.mkdir('tmp') if !File.directory? 'tmp'

		load_params psOSname
		install_packages
		download_files
		configure_users
		process_commands
	end
	
	def load_params(psOSname)
		verbose "\n[INFO] Loading params..."

		if !File.directory? "config/#{psOSname}" then
			e=Dir.new("config").entries-[".",".."]
			print "[ERROR] Configuration <#{psOSname}> dosn't exist!. Try with: "
			e.sort.each { |i| print i+', '}
			print "\n"
			raise "Configuration <#{psOSname}> dosn't exist!"
		end
		filename="config/#{psOSname}/params.yaml"
		@param = YAML::load(File.open(filename))
		@param[:os_name]=psOSname || 'default'
		@debug=@param[:debug_option] || false
		@verbose=@param[:verbose_option] || true
		@logfile="tmp/#{@param[:os_name]}.log" 
		File.open(@logfile,'w') do |f|
			f.write("File: #{@logfile}\n")
			f.write("Time: "+Time.new.to_s)
			f.write("\n\n")
		end
		verbose @param
	end
	
	def install_packages
		return if !@param[:install_packages]
		verbose "\n[INFO] Installing packages..."

		execute_command(@param[:refresh_cmd])
		filename="config/#{@param[:os_name]}/packages.yaml"
		list = YAML::load(File.open(filename))
		
		list.each do |line|	
			item=line.split(" ")
			item.each do |p|
				#Generate specific command for the system and the package
				package_name=p
				template = ERB.new(@param[:package_test_cmd].to_s)
				package_test_cmd = template.result(binding)

				r = IO.popen(package_test_cmd).readlines
				if r[0].to_i==1 then
					verbose "(=) Package <#{p}> already installed!"
				else
					execute_command("#{@param[:install_cmd]} #{p}") 
				end
			end
		end
		execute_command(@param[:upgrade_cmd]) 
	end
	
	def download_files
		return if !@param[:download_files]
		verbose "\n[INFO] Downloading files from repo..."
		
		filename="config/#{@param[:os_name]}/downloads.yaml"
		data = YAML::load(File.open(filename))
		dir = data[:dir]
		list = data[:files]
		list.each do |i|
			execute_command( "wget #{@param[:repo_url]}/#{i}" )
			execute_command( "mv #{i} #{dir}/#{i}" )
		end
	end

	def process_commands
		return if !@param[:process_commands]
		verbose "\n[INFO] Processing commands..."
		dirname="config/#{@param[:os_name]}/scripts"
		raise "Directory <#{dirname}> not found!" if !File.directory? dirname

		execute_command("chmod +x #{dirname}/*.sh")
		execute_command("chmod +x #{dirname}/*.rb")

		list=(Dir.new(dirname).entries-[".",".."]).sort
		list.each { |cmd| execute_command(cmd) }
	end

	def configure_users
		return if !@param[:configure_users]
		verbose "\n[INFO] Configuring users..."
		
		filename="config/#{@param[:os_name]}/users.yaml"
		list=YAML::load(File.open(filename))
		
		list.each do |i|
			name = i[:name]
			home = i[:home] || "/home/#{name}"
			maingroup = i[:maingroup] || i[:name]
			passwd = i[:passwd] || i[:name]
			shell = i[:shell] || '/bin/bash'
			othergroups = i[:othergroups]
			force_delete = i[:force_delete] || false
			uid = i[:uid] || -1
						
			#Create group if needed
			r = IO.popen("cat /etc/group| grep #{maingroup}|wc -l").readlines
			if r[0].to_i==1 then
				verbose "(=) Group #{maingroup} exists!"
			else
				execute_command( "groupadd #{maingroup}" )
			end
			
			#Create user if needed
			execute_command("userdel -r #{i[:name]}") if force_delete

			r = IO.popen("cat /etc/passwd| grep '#{name}:'|wc -l").readlines
			if r[0].to_i==1 then
			   verbose "(=) User #{name} exists!"
			else
			   s="useradd #{name}"
			   s=s+" --home #{home} --create-home"
                           s=s+" -g #{maingroup}"
                           s=s+" --shell #{shell}"
                           s=s+" --uid #{uid}" if uid>=0
			   execute_command(s)
			end
			execute_command( "usermod #{name} --groups #{othergroups}" )
			execute_command( "echo \"#{name}:#{passwd}\" | chpasswd")
		end
	end
			
private
	
	def execute_command(lsCommand)
		verbose "(*) Executing: #{lsCommand}"
		system(lsCommand) if !@debug
	end
		
	def verbose(lsText)
		if @verbose then
			puts lsText
			File.open(@logfile,'a') do |f|
				f.write(lsText.to_s+"\n")
			end
		end
	end
end	
