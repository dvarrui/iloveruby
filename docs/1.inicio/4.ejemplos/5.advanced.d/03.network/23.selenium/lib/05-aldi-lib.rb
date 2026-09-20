
require "selenium-webdriver"
require "colorize"

class AldiPhoneNumber
  attr_reader :driver

  def initialize(url)
    @url = url
    @driver = Selenium::WebDriver.for :firefox
    @driver.get @url
    @driver.manage.timeouts.implicit_wait = 30
  end

  def get(code)
    click_button("SALTAR")
    filter(code, debug: true)
    if exist_button? "Continuar"
      puts "    [SKIP] Continuar button"
      # aldi.click_button("Continuar")
    else
      click_link("Mapa")
      click_button("Calcule la ruta:")
    end
    puts "    Teléfono: #{get_telefono.colorize(:green)}"
    quit
  end

  private

  def pause
    puts "(Push enter to continue)".colorize(:light_yellow)
    gets
  end

  def click_button(text, debug: false)
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

  def exist_button?(text)
    @driver.find_elements(:tag_name, 'button').each do |button|
      return true if button.text == text
    end
    false
  end

  def filter(code, debug: false)
    @driver.navigate.refresh
    select_element = @driver.find_element(name: "Radius")
    select = Selenium::WebDriver::Support::Select.new(select_element)
    select.select_by(:text,'5 km')

    @driver.find_element(name: 'Zip').send_keys code, :return
    puts "==> filter by Zip: #{code.colorize(:white)}" if debug

    handles = @driver.window_handles
    @driver.switch_to.window(handles[1])
  end

  def click_link(text, debug: false)
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

  def get_telefono
    begin
      e = @driver.find_element(id: "RoutingAddressPhone")
      return e.text.split.last
    rescue
      return ""
    end
  end

  def quit
    @driver.quit
  end
end
