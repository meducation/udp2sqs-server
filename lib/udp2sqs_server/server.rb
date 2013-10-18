require 'propono'

module Udp2sqsServer
  class Server

    def self.run(*args)
      new(*args).run
    end

    # TODO Duplicated - but new.config is failing.
    def self.config
      Configuration.instance
    end

    def initialize(options = {})
      @host = options.fetch(:host, "0.0.0.0")
      @port = options.fetch(:port, 9732)

      Propono.config.access_key = config.access_key
      Propono.config.secret_key = config.secret_key
      Propono.config.queue_region = config.queue_region
    end

    def run
      Propono.listen_to_sqs do |text|
        Propono.publish(config.topic, text)
      end
    end

    private

    def config
      Configuration.instance
    end
  end
end


