require "pergo/version.rb"
require "pergo/configuration.rb"
require "pergo/server.rb"

module Pergo

  def self.config
    Configuration.instance
  end

end
