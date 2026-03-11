#!/usr/bin/env ruby

class Fase
  def initialize(id, duration = 3)
    @id = id.to_s
    @duration = duration
    @output = nil
  end

  def send(input)
    @output = input.to_s + @id
    puts "[Fase #{@id}] #{input} >> #{@output}"
    sleep(@duration)
  end

  def take
    @output
  end
end

fase1 = Fase.new(1)
fase2 = Fase.new(2)
fase3 = Fase.new(3)

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
