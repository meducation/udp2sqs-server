require 'eventmachine'
require "udp2sqs_server/instance"

module Udp2sqsServer
  class Server

    def self.run(*args)
      new(*args).run
    end

    def initialize(options = {})
      @host = options.fetch(:host, "0.0.0.0")
      @port = options.fetch(:port, 9732)
      EM.threadpool_size = options.fetch(:threadpool_size, 100)
    end

    def run
      EM.run { Instance.run(@host, @port) }
    end
  end
end


