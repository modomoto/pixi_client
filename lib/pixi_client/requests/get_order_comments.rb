module PixiClient
  module Requests
    class GetOrderComments < Base
      attr_accessor :pixi_order_number

      def initialize(pixi_order_number)
        self.order_id = order_id
      end

      def api_method
        :pixi_get_order_comments
      end

      def message
        { 'OrderNr' => pixi_order_number }
      end
    end
  end
end
