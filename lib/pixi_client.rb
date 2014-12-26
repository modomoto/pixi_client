require 'pixi_client/version'
require 'pixi_client/configuration'
require 'pixi_client/soap_client'

module PixiClient
  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end
