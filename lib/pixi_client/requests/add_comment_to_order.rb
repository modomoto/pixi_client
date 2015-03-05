module PixiClient
  module Requests
    class AddCommentToOrder < Base
      attr_accessor :order_nr, :comment

      def initialize(order_nr, comment)
        self.order_nr = order_nr
        self.comment = comment
      end

      def api_method
        :pixi_add_order_comment
      end

      def message
        { 'OrderNr' => order_nr, 'Comment' => comment }
      end
    end
  end
end
