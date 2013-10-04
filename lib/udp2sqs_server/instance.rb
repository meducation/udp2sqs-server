require 'socket'
require 'fog'

module Udp2sqsServer
  class Instance

    def self.run(*args)
      new(*args).run
    end

    def initialize(host, port)
      @host, @port = host, port
    end

    def run
      defer_warmup_threads
      defer_operations
    end

    private

    def defer_operations
      loop { defer_operation } 
    end

    def defer_operation
      text, sender = socket.recvfrom(1024)
      EM.defer do 
        sqs = Fog::AWS::SQS.new(
         aws_access_key_id:     config['access_key'],
         aws_secret_access_key: config['secret_key'],
         region:                config['queue_region']
        )
        sqs.send_message(config['queue_url'], text)
      end
    end

    def defer_warmup_threads
      EM.defer do
        i = 0
        i += 1
      end
    end

    def config
      @config ||= YAML.load_file("queue.yaml")
    end

    def socket
      @socket ||= begin
        UDPSocket.new.tap do |socket|
          socket.bind(@host, @port)
        end
      end
    end
  end
end
