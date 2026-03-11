#!/usr/bin/ruby
#File: builder.rb

require 'erb'
#require 'yaml'
#require_relative 'snapshot'
require 'yaml'
YAML::ENGINE.yamler = 'syck'

class Builder
	attr_accessor :debug, :verbose
	attr_reader :package_name

	def self.version
		"0.0.22"
	end
	
	def initialize
		@param={}
		@debug=false
		@verbose=true
		@logfile='tmp/default.log'
	end
	
	def do(pArgs)
		if pArgs.count > 0 then
			build_system(pArgs[0])
		else
			puts "Usage: #{$0} --help"
		end
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

		if !File.directory? "project/#{psOSname}" then
			e=Dir.new("project").entries-[".",".."]
			print "[ERROR] Project configuration <#{psOSname}> dosn't exist!. Try with: "
			e.sort.each { |i| print i+', '}
			print "\n"
			raise "Project configuration <#{psOSname}> dosn't exist!"
		end
		filename=File.join("project", psOSname, "config.yaml")
		@param = YAML::load(File.open(filename))
		@param[:os_name]=psOSname || 'default'
		@param[:basedir]=@param[:basedir] || 'project'
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
		filename="#{@param[:basedir]}/#{@param[:os_name]}/packages.yaml"
		config = YAML::load(File.open(filename))
		list=config[:install]
		list.each do |line|	
			item=line.split(" ")
			item.each do |p|
				#Generate specific command for the system and the package
				package_name=p
				template = ERB.new(@param[:package_test_cmd].to_s)
				package_test_cmd = template.result(binding)

				r = IO.popen(package_test_cmd).readlines
				if r[0].to_i==1 then
					verbose "(=) Package <#{p}> installed!"
				else
					execute_command("#{@param[:install_cmd]} #{p}") 
				end
			end
		end

		list=config[:remove]
		list.each do |line|	
			item=line.split(" ")
			item.each do |p|
				#Generate specific command for the system and the package
				package_name=p
				template = ERB.new(@param[:package_test_cmd].to_s)
				package_test_cmd = template.result(binding)

				r = IO.popen(package_test_cmd).readlines
				if r[0].to_i==1 then
					execute_command("#{@param[:remove_cmd]} #{p}") 
				else
					verbose "(=) Package <#{p}> not installed!"
				end
			end
		end
		
		execute_command(@param[:upgrade_cmd]) 
	end
	
	def download_files
		return if !@param[:download_files]
		verbose "\n[INFO] Downloading files from repo..."
		
		filename="#{@param[:basedir]}/#{@param[:os_name]}/downloads.yaml"
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
		dirname="./#{@param[:basedir]}/#{@param[:os_name]}/scripts.d"
		raise "Directory <#{dirname}> not found!" if !File.directory? dirname

		execute_command("chmod +x #{dirname}/*.sh")
		execute_command("chmod +x #{dirname}/*.rb")

		list=(Dir.new(dirname).entries-[".",".."]).sort
		list.each { |cmd| execute_command("#{dirname}/#{cmd}") }
	end

	def configure_users
		return if !@param[:configure_users]
		verbose "\n[INFO] Configuring users..."
		
		filename="#{@param[:basedir]}/#{@param[:os_name]}/users.yaml"
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
			og=othergroups.split(",")
			og.each do |group| 
				r = `cat /etc/group| grep #{group}|wc -l`
				if r.to_i==1 then
					verbose "(=) Group #{group} exists!"
				else
					execute_command( "groupadd #{group}" )
				end
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
			File.open(@logfile,'a') { |f| f.write(lsText.to_s+"\n") }
		end
	end
end	


