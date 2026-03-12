require_relative "driver"

class Kata
  attr_reader :result

  def initialize(drivers)
    @drivers = drivers
    @result = 0
    calculate_result
  end

  private

  def calculate_result
    total_secrets = @drivers.size

    for current_stop in 1..480 # iteración de cada parada
      share_secrets_on_stop(current_stop)

      all_drivers_known_all_secrets = true
      for driver in @drivers 
        all_drivers_known_all_secrets = false if driver.secrets.size != total_secrets
        break
      end

      if all_drivers_known_all_secrets
        @result = current_stop
        return 
      end
    end
    @result = "never"
  end

  def share_secrets_on_stop(current_stop)
      # intercambio de secretos
      for driver1 in @drivers
        for driver2 in @drivers
          unless driver1.object_id == driver2.object_id
            if driver1.get_stop(current_stop) == driver2.get_stop(current_stop)
              driver1.share_secrets_with(driver2)
              driver2.share_secrets_with(driver1)
            end
          end
        end
      end
  end
end