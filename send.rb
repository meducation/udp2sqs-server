#!/usr/bin/env ruby

require 'socket'

message = ARGV[0]
hostname = ARGV[1]

i = 0
1000.times do 
  i += 1
  s = UDPSocket.new
  msg = "#{message} #{i}"
  s.send(msg, 0, hostname, 9732)
  puts "Sent #{i}"
end
