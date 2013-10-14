require 'socket'
require 'fog'

module Udp2sqsServer
  class Server

    def self.run(*args)
      new(*args).run
    end

    def initialize(options = {})
      @host = options.fetch(:host, "0.0.0.0")
      @port = options.fetch(:port, 9732)
    end

    def run
      loop { store_message }
    end

    private

    # Receives text and sender and saves it in SQS
    def store_message
      text = socket.recvfrom(1024)[0]
      Thread.new { sqs.send_message(config['queue_url'], text) }
    end

    def socket
      @socket ||= begin
        socket = UDPSocket.new
        socket.bind(@host, @port)
        socket
      end
    end

    def config
      @config ||= YAML.load_file("queue.yaml")
    end

    def sqs
      @sqs ||= Fog::AWS::SQS.new(
       aws_access_key_id:     config['access_key'],
       aws_secret_access_key: config['secret_key'],
       region:                config['queue_region']
      )
    end

  end
end


