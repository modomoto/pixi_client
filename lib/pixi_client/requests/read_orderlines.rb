module PixiClient
  module Requests
    class ReadOrderlines < Base
      attr_accessor :message

      # Pixi* documentation says that the pixi order number
      # is mandatory for this requests
      def initialize(message)
        self.message = message
      end

      def api_method
        :pixi_read_orderlines
      end

    end
  end
end
