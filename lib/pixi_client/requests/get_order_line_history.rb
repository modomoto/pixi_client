module PixiClient
  module Requests
    class GetOrderLineHistory < Base
      attr_accessor :order_line_key

      # Pixi* documentation says that the pixi order number
      # is mandatory for this requests
      def initialize(order_line_key)
        self.order_line_key = order_line_key
      end

      def api_method
        :pixi_get_orderline_history
      end

      def message
        { 'OrderlineKey' => order_line_key}
      end

    end
  end
end
