require 'pixi_client/version'
require 'pixi_client/error'
require 'pixi_client/configuration'
require 'pixi_client/response_parser'
require 'pixi_client/response'
require 'pixi_client/requests'
require 'pixi_client/railtie' if defined?(Rails)

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
