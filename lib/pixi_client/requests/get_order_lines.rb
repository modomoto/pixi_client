module PixiClient
  module Requests
    class GetOrderLines < Base
      attr_accessor :pixi_order_number

      # Pixi* documentation says that the pixi order number
      # is mandatory for this requests
      def initialize(pixi_order_number)
        self.pixi_order_number = pixi_order_number
      end

      def api_method
        :pixi_get_orderline
      end

      def message
        { 'OrderNR' => pixi_order_number }
      end
    end
  end
end
