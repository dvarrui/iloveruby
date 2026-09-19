r = Ractor.new { puts "[ractor1] This is my first ractor (#{Process.pid})" }
# This is my first ractor
# create a ractor with a name
r = Ractor.new name: 'second_ractor' do
  puts "[ractor2] This is my second ractor (#{Process.pid})"
end
# This is my second ractor

puts "[main] Ractor name #{r.name} (#{Process.pid})"
# => "second_ractor"
sleep 1
