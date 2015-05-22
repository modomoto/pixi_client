module PixiClient
  module Requests
    class GetItemsStockHistory < Base
      attr_accessor :message

      # Pixi* documentation says that the pixi order number
      # is mandatory for this requests
      def initialize(message)
        self.message = message
      end

      def api_method
        :pixi_get_items_stock_history
      end

    end
  end
end
