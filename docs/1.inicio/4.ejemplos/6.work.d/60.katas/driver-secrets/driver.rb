class Driver
  attr_reader :secrets

  def initialize(stops, secret)
    @stops = stops
    @secrets = [ secret ]
  end

  def share_secrets_with(other)
    new_secrets = @secrets | other.secrets
    @secrets = new_secrets.sort
  end

  def get_stop(index)
    stop_index = (index - 1) % @stops.count
    @stops[stop_index]
  end
end