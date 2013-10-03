require 'socket'
require 'fog'
require 'eventmachine'

module Udp2sqsServer

  class Server

    def initialize
      @host, @port, @threadpool_size = "0.0.0.0", 9732, 100
    end

    def configure(host: "0.0.0.0", port: 9732, threadpool_size: 100)
      @host, @port, @threadpool_size = host, port, threadpool_size
    end

    def run
      EM.threadpool_size = @threadpool_size
      EM.run do
        warmup_threads = proc do
          i = 0
          i += 1
        end
        EM.defer(warmup_threads)

        config = YAML.load_file("queue.yaml")

        s = UDPSocket.new
        s.bind(@host, @port)
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
    end
  end
end


