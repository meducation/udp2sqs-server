require File.expand_path('../test_helper', __FILE__)

module Udp2sqsServer
  class ConfigurationTest < Minitest::Test
    def config
      @config ||= Configuration.send(:new)
    end

    def test_obtaining_singletion
      refute config.nil?
    end

    def test_unable_to_create_instance
      assert_raises(NoMethodError) do
        config = Configuration.new
      end
    end

    def test_access_key
      access_key = "test-access-key"
      config.access_key = access_key
      assert_equal access_key, config.access_key
    end

    def test_secret_key
      secret_key = "test-secret-key"
      config.secret_key = secret_key
      assert_equal secret_key, config.secret_key
    end

    def test_topic
      topic = "test-topic"
      config.topic = topic
      assert_equal topic, config.topic
    end

    def test_missing_access_key_throws_exception
      assert_raises(ConfigurationError) do
        config.access_key
      end
    end

    def test_missing_secret_key_throws_exception
      assert_raises(ConfigurationError) do
        config.secret_key
      end
    end

    def test_missing_topic_throws_exception
      assert_raises(ConfigurationError) do
        config.topic
      end
    end
  end
end
