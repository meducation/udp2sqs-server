require 'socket'

port = ARGV[0]
puts port

s = UDPSocket.new
s.bind(nil, port)
5.times do
  text, sender = s.recvfrom(16)
  puts text
end
