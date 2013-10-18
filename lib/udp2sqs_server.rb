require "udp2sqs_server/version.rb"
require "udp2sqs_server/configuration.rb"
require "udp2sqs_server/server.rb"

module Udp2sqsServer

  def self.config
    Configuration.instance
  end

end
