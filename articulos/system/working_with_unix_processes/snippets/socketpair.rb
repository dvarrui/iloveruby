require 'socket'
Socket.pair(:UNIX, :DGRAM, 0) #=> [#<Socket:fd 15>, #<Socket:fd 16>]

