#!/usr/bin/ruby
#File: application.rb

require 'erb'
#require 'yaml'
require 'yaml'
YAML::ENGINE.yamler = 'syck'

class Application
	
	def initialize(pParent, params)
		@main=pParent
		@debug=@output.debug
		@verbose=@output.verbose
		@param=params
	end
	
	def run
		return if !@param[:install_packages]
		install_packages
		remove_packages
		@main.execute_command(@param[:upgrade_cmd]) 
		#modify_configuration_files
	end
			
	def install_packages
		@main.verbose "\n[INFO] Installing packages..."
		@main.execute_command(@param[:refresh_cmd])
		
		filename=File.join(@param[:basedir], @param[:os_name], "packages.yaml")
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
					@main.verbose "(=) Package <#{p}> installed!"
				else
					@main.execute_command("#{@param[:install_cmd]} #{p}") 
				end
			end
		end
	end

	def remove_packages
		@main.verbose "\n[INFO] Removing packages..."
		@main.execute_command(@param[:refresh_cmd])

		filename=File.join( @param[:basedir], @param[:os_name], "packages.yaml")
		config = YAML::load(File.open(filename))

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
	end
	
	def modify_configuration_files
	end	
end	
