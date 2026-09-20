#!/usr/bin/env ruby

module Observable
 def register(event=nil, &callback)
   @observers ||= Hash.new
   @observers[event] ||= []
   @observers[event] << callback
   self
 end

 protected

 def signal_event(event = nil, *args)
   @observers ||= Hash.new
   @observers[event] ||= []
   @observers[event].each { |callback| callback.call(self, *args) }
 end
end

class Observed
  include Observable
  def foo=(value)
    signal_event(:changed, @foo, value)
    @foo = value
  end
end

observed = Observed.new
observed.register(:changed) { | o, old, new | puts "[#{o}] #{old} --(changed)--> #{new}" }

observed.foo = 'Yukihiro'
observed.foo = 'Matsumoto'
observed.foo = 'Matz'

# −> Yukihiro
#Yukihiro −> Yukihiro Matsumoto
#Yukihiro Matsumoto −> Matz

