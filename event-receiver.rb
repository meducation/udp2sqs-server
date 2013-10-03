#!/usr/bin/env ruby

require 'socket'
require 'fog'
require 'eventmachine'

EM.threadpool_size = 100
EM.run do
  warmup_threads = proc do
    i = 0
    i += 1
  end
  EM.defer(warmup_threads)
  port = ARGV[0]
  #puts "I am #{Process.pid} look in /proc/#{Process.pid}/net/snmp"
  puts "Listening on port: #{port}"

  config = YAML.load_file("queue.yaml")

  s = UDPSocket.new
  s.bind('0.0.0.0', port)
  loop do
    text, sender = s.recvfrom(1024)
    operation = proc do
      sqs = Fog::AWS::SQS.new(
       :aws_access_key_id => config['access_key'],
       :aws_secret_access_key => config['secret_key'],
       :region => config['queue_region']
      )
      sqs.send_message(config['queue_url'], text)
    end
    EM.defer(operation)
  end
end
