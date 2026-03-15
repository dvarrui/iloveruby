
require "selenium-webdriver"
require "colorize"

class SeleniumWrapper
  attr_reader :driver

  def initialize(url)
    @url = url
    # @driver = Selenium::WebDriver.for :firefox
    options = Selenium::WebDriver::Firefox::Options.new
    # options.headless!
    options.add_argument('-headless')

    @driver = Selenium::WebDriver.for(:firefox, capabilities: [options])
    @driver.get @url
    @driver.manage.timeouts.implicit_wait = 30
  end

  def pause
    puts "(Push enter to continue)".colorize(:light_yellow)
    gets
  end

  def click_button(text, debug: true)
    @driver.find_elements(:tag_name, 'button').each do |button|
      if button.text == text
        puts "==> click button #{button.text.colorize(:white)}" if debug
        begin
          button.click
          return true
        rescue Selenium::WebDriver::Error::UnexpectedAlertOpenError
          return false
        end
      end
    end

    @driver.quit
    puts "    [ERROR] #{text} button not found!".colorize(:light_red)
    exit 1
  end

  def click_button_attr(attr_name, text, debug: true)
    @driver.find_elements(:tag_name, 'button').each do |button|
      if button.attribute(attr_name) == text
        puts "==> click button #{attr_name}=#{text}" if debug
        button.click
      end
    end

    @driver.quit
    puts "    [ERROR] #{text} button not found!".colorize(:light_red)
    exit 1
  end

  def exist_button?(text)
    @driver.find_elements(:tag_name, 'button').each do |button|
      return true if button.text == text
    end
    false
  end

  def click_link(text, debug: true)
    @driver.navigate.refresh
    @driver.find_elements(:tag_name, 'a').each do |a|
      if a.text == text
        puts "==> click link #{a.text.colorize(:white)}" if debug
        a.click
        return true
      end
    end

    @driver.quit
    puts "    [ERROR] #{text} link not found!".colorize(:light_red)
    exit 1
  end

  def quit
    @driver.quit
  end
end
