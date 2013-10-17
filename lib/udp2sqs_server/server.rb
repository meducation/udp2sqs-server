require 'socket'
require 'propono'

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
      Thread.new { Propono.publish(config.topic, text) }
    end

    def socket
      @socket ||= begin
        socket = UDPSocket.new
        socket.bind(@host, @port)
        socket
      end
    end

    def config
      Configuration.instance
    end
  end
end


