#!/usr/bin/env ruby

fase1 = Ractor.new do
  loop do
    name = "fase1"
    input = Ractor.receive
    output = input + "1"
    puts "[Ractor #{name}] #{input} >> #{output}"
    sleep(3)
    Ractor.yield output
  end
end

fase2 = Ractor.new do
  loop do
    name = "fase2"
    input = Ractor.receive
    output = input + "2"
    puts "[Ractor #{name}] #{input} >> #{output}"
    sleep(3)
    Ractor.yield output
  end
end

fase3 = Ractor.new do
  loop do
    name = "fase3"
    input = Ractor.receive
    output = input + "3"
    puts "[Ractor #{name}] #{input} >> #{output}"
    sleep(3)
    Ractor.yield output
  end
end

tasks = ['A', 'B', 'C']
tasks.each do |task|
  fase1.send(task)
  f1out = fase1.take

  fase2.send(f1out)
  f2out = fase2.take

  fase3.send(f2out)
  f3out = fase3.take
  puts "==> output: #{f3out}"
end

sleep 1
