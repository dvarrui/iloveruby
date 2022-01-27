
class MyConfig
  attr_reader :begin_time, :talk_name

  def initialize
    @begin_time = Time.local(2016,4,22,16,0,0)
    @talk_name = "#chapi16"
  end

  def time_left
    now_time=Time.now		
    return ((now_time-@begin_time)/60).to_i
  end
end

