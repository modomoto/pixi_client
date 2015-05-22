module PixiClient
  module Requests
    class GetStock < Base
      attr_accessor :exclude_zeros

      def initialize(exclude_zeros = true)
        self.exclude_zeros = exclude_zeros
      end

      def api_method
        :pixi_shop_link_get_items_stock
      end

      def message
        { 'ExcludeZeros' => exclude_zeros }
      end
    end
  end
end
