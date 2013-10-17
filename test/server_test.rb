require File.expand_path('../test_helper', __FILE__)

module Udp2sqsServer
  class ServerTest < Minitest::Test

    def test_initializes
      server = Server.new
      assert_equal "0.0.0.0", server.instance_variable_get("@host")
      assert_equal 9732,      server.instance_variable_get("@port")
    end

    def test_message_is_stored
      topic = "my-topic"
      text = "Foobar123"
      config.topic = topic
      Propono.expects(:publish).with(topic, text)
      server = Server.new
      socket = mock(recvfrom: [text])
      server.stubs(socket: socket)
      thread = server.send(:store_message)
      thread.join
    end
  end
end
