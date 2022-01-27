#---
# Excerpted from "Everyday Scripting in Ruby"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/bmsft for more book information.
#---
require 'test/unit'
$:.unshift '../lib'
require 'rubygems'
require 'test/mockgemui'
Gem::manage_gems

class TestParseCommands < Test::Unit::TestCase
  include Gem::DefaultUserInteraction

  def setup
    @cmd_manager = Gem::CommandManager.new
  end

  def test_parsing_bad_options
    use_ui(MockGemUi.new) do
      assert_raises(MockGemUi::TermError) {
	@cmd_manager.process_args("--bad-arg")
      }
      assert_match /invalid option: --bad-arg/i, ui.error
    end
  end

  def test_parsing_install_options
    #capture all install options
    use_ui(MockGemUi.new) do
      check_options = nil
      @cmd_manager['install'].when_invoked do |options|
	check_options = options
	true
      end
      
      #check defaults
      @cmd_manager.process_args("install")
      assert_equal false, check_options[:test]
      assert_equal true, check_options[:generate_rdoc]
      assert_equal false, check_options[:force]
      assert_equal :both, check_options[:domain]
      assert_equal true, check_options[:wrappers]
      assert_equal "> 0", check_options[:version]
      assert_equal Gem.dir, check_options[:install_dir]
      
      #check settings
      check_options = nil
      @cmd_manager.process_args(
	"install --force --test --local --rdoc --install-dir . --version 3.0 --no-wrapper")
      assert_equal true, check_options[:test]
      assert_equal true, check_options[:generate_rdoc]
      assert_equal true, check_options[:force]
      assert_equal :local, check_options[:domain]
      assert_equal false, check_options[:wrappers]
      assert_equal '3.0', check_options[:version]
      assert_equal '.', check_options[:install_dir]
      
      #check remote domain
      check_options = nil
      @cmd_manager.process_args("install --remote")
      assert_equal :remote, check_options[:domain]
      
      #check both domain
      check_options = nil
      @cmd_manager.process_args("install --both")
      assert_equal :both, check_options[:domain]
      
      #check both domain
      check_options = nil
      @cmd_manager.process_args("install --both")
      assert_equal :both, check_options[:domain]
    end
  end
  
  def test_parsing_uninstall_options
    #capture all uninstall options
    check_options = nil
    @cmd_manager['uninstall'].when_invoked do |options|
      check_options = options
      true
    end
    
    #check defaults
    @cmd_manager.process_args("uninstall")
    assert_equal "> 0", check_options[:version]

    #check settings
    check_options = nil
    @cmd_manager.process_args("uninstall foobar --version 3.0")
    assert_equal "foobar", check_options[:args].first
    assert_equal "3.0", check_options[:version]
  end

  def test_parsing_check_options
    #capture all check options
    check_options = nil
    @cmd_manager['check'].when_invoked do |options|
      check_options = options
      true
    end
    
    #check defaults
    @cmd_manager.process_args("check")
    assert_equal false, check_options[:verify]
    assert_equal false, check_options[:alien]

    #check settings
    check_options = nil
    @cmd_manager.process_args("check --verify foobar --alien")
    assert_equal "foobar", check_options[:verify]
    assert_equal true, check_options[:alien]
  end
    
  def test_parsing_build_options
    #capture all build options
    check_options = nil
    @cmd_manager['build'].when_invoked do |options|
      check_options = options
      true
    end
    
    #check defaults
    @cmd_manager.process_args("build")
    #NOTE: Currently no defaults
    
    #check settings
    check_options = nil
    @cmd_manager.process_args("build foobar.rb")
    assert_equal 'foobar.rb', check_options[:args].first
  end
  
  def test_parsing_query_options
    #capture all query options
    check_options = nil
    @cmd_manager['query'].when_invoked do |options|
      check_options = options
      true
    end
    
    #check defaults
    @cmd_manager.process_args("query")
    assert_equal /.*/, check_options[:name]
    assert_equal :local, check_options[:domain]
    assert_equal false, check_options[:details]
    
    #check settings
    check_options = nil
    @cmd_manager.process_args("query --name foobar --local --details")
    assert_equal /foobar/i, check_options[:name]
    assert_equal :local, check_options[:domain]
    assert_equal true, check_options[:details]

    #remote domain
    check_options = nil
    @cmd_manager.process_args("query --remote")
    assert_equal :remote, check_options[:domain]

    #both (local/remote) domains
    check_options = nil
    @cmd_manager.process_args("query --both")
    assert_equal :both, check_options[:domain]
  end  
  
  def test_parsing_update_options
    #capture all update options
    check_options = nil
    @cmd_manager['update'].when_invoked do |options|
      check_options = options
      true
    end
    
    #check defaults
    @cmd_manager.process_args("update")
    assert_equal true, check_options[:generate_rdoc]
    
    #check settings
    check_options = nil
    @cmd_manager.process_args("update --force --test --rdoc --install-dir .")
    assert_equal true, check_options[:test]
    assert_equal true, check_options[:generate_rdoc]
    assert_equal true, check_options[:force]
    assert_equal '.', check_options[:install_dir]
  end 
  
end
