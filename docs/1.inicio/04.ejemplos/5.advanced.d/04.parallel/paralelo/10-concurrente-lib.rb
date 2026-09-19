
def do_something(id, delay, mutex)
  puts "[#{id}] BEGIN  :   delay = #{ delay.to_i}"
  delay.to_i.times do
    mutex.synchronize do
      c = @counter
      c +=1
      sleep(1)
      @counter = c
    end
  end
  puts "[#{id}] END    : counter = #{@counter}"
end

def begin_work(values)
  puts "="*60
  puts "    Script : #{$0} "
  puts "    Inputs : #{values.to_s}"
  puts "    Counter: #{@counter}"
  puts "    Result : This program works because use mutex."
  puts "="*60
  @begintime = Time.now
end

def end_work
  duration = Time.now-@begintime
  puts "="*60
  puts "    Total duration = #{duration.to_i}"
  puts "           Counter = #{@counter}"
  puts "="*60
end

class Array

  def parallelize(action)
    tasks = []
    mutex = Mutex.new
    each_with_index do |input, index|
      tasks << Thread.new{ action.call(index, input, mutex)}
    end
    tasks.each { |t| t.join }
  end

end
