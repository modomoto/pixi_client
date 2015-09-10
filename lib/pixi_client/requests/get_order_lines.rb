module PixiClient
  module Requests
    class GetOrderLines < Base
      attr_accessor :pixi_order_number

      # Pixi* documentation says that the pixi order number
      # is mandatory for this requests
      def initialize(options = {})

        if options[:pixi_order_number]
          @pixi_order_number = options[:pixi_order_number]
        elsif options[:message]
          @message = options[:message]
        else
          fail('Parameters must include either pixi_order_number or message-Hash')
        end
      end

      def api_method
        :pixi_get_orderline
      end

      def message
        return @message if @message
        { 'OrderNR' => pixi_order_number }
      end
    end
  end
end
