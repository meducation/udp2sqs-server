require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

gem "minitest"
require "minitest/autorun"
require "minitest/pride"
require "minitest/mock"
require "mocha/setup"

lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "udp2sqs_server"

#Fog.mock!

class Minitest::Test
  def setup
    Udp2sqsServer::Configuration.instance.access_key = "test-access-key"
    Udp2sqsServer::Configuration.instance.secret_key = "test-secret-key"
    Udp2sqsServer::Configuration.instance.topic = "test-topic"
  end

  def config
    Udp2sqsServer::Configuration.instance
  end
end

