module PixiClient
  module Requests
    class CancelOrderLine < Base
      attr_accessor :order_line_key

      def initialize(order_line_key)
        self.order_line_key = order_line_key
      end

      def api_method
        :pixi_cancel_orderline
      end

      def message
        { 'OrderlineKey' => order_line_key }
      end
    end
  end
end
