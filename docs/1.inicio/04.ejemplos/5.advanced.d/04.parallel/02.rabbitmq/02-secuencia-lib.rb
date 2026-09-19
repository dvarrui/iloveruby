
def do_something(id, delay)
  puts "[#{id}] BEGIN  : delay = #{ delay.to_i}"
  sleep(delay)
  puts "[#{id}] END   "
end

def begin_work(values)
  puts "="*40
  puts "    Script : #{$0} "
  puts "    Inputs : #{values.to_s}"
  puts "="*40
  @begintime = Time.now
end

def end_work
  duration = Time.now-@begintime
  puts "="*40
  puts "    Total duration = #{duration.to_i}"
  puts "="*40
end
