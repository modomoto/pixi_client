require 'pixi_client/version'
require 'pixi_client/configuration'
require 'pixi_client/response_parser'
require 'pixi_client/response'
require 'pixi_client/soap_request'
require 'pixi_client/requests/get_changed_item_stock_request'
require 'pixi_client/responses/get_changed_item_stock_response'

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
