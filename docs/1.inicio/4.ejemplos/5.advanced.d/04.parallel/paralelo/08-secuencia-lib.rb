
def do_something(id, delay)
  puts "[#{id}] BEGIN  :   delay = #{ delay.to_i}"
  delay.to_i.times do
    @counter+=1
    sleep(1)
  end
  puts "[#{id}] END    : counter = #{@counter}"
end

def begin_work(values)
  puts "="*60
  puts "    Script : #{$0} "
  puts "    Inputs : #{values.to_s}"
  puts "    Counter: #{@counter}"
  puts "    Result : This program works fine without using mutex."
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
