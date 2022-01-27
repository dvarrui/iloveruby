#---
# Excerpted from "Everyday Scripting in Ruby"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/bmsft for more book information.
#---
require 'yaml'
require 'rubygems'
require 'rubygems/source_index'

YAML_DATA = <<EOS
--- !ruby/object:Gem::Cache
gems:
  rake-0.4.11: !ruby/object:Gem::Specification 
    rubygems_version: "0.7"
    specification_version: 1
    name: rake
    version: !ruby/object:Gem::Version 
      version: 0.4.11
    date: 2004-11-12
    summary: Ruby based make-like utility.
    require_paths: 
      - lib
    author: Jim Weirich
    email: jim@weirichhouse.org
    homepage: http://rake.rubyforge.org
    rubyforge_project: rake
    description: Rake is a Make-like program implemented in Ruby. Tasks and dependencies are specified in standard Ruby syntax.
    autorequire: 
    default_executable: rake
    bindir: bin
    has_rdoc: true
    required_ruby_version: !ruby/object:Gem::Version::Requirement 
      requirements: 
        - 
          - ">"
          - !ruby/object:Gem::Version 
            version: 0.0.0
      version: 
    platform: ruby
    files: 
      - README
    test_files: []
    library_stubs: 
    rdoc_options: 
    extra_rdoc_files: 
    executables: 
      - rake
    extensions: []
    requirements: []
    dependencies: []
EOS

PROXY_DATA = YAML_DATA.gsub(/0.4.11/, '0.4.2')

def cache_hash(*uris)
  result = Hash.new
  uris.each do |uri|
    result[uri] = {
      'size' => YAML_DATA.size,
      'cache' => YAML.load(YAML_DATA)
    }
  end
  result
end
