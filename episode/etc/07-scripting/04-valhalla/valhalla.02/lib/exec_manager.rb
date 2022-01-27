
require_relative 'localhost'
require_relative 'host'

class ExecManager

  def run
    h = LocalHost.new()
    h.run('pwd')
    h.run('whoami')
  end

end
