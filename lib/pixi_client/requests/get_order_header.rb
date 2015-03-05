module PixiClient
  module Requests
    class GetOrderHeader < Base
      attr_accessor :order_id

      def initialize(order_id)
        self.order_id = order_id
      end

      def api_method
        :pixi_get_order_header
      end

      def message
        { 'OrderNrExternal' => order_id }
      end
    end
  end
end
