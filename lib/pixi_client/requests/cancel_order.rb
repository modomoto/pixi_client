module PixiClient
  module Requests
    class CancelOrder < Base
      attr_accessor :order_nr

      def initialize(order_nr)
        self.order_nr = order_nr
      end

      def api_method
        :pixi_cancel_order
      end

      def message
        { 'OrderNr' => order_nr }
      end
    end
  end
end
