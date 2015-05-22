module PixiClient
  module Requests
    class GetItemsOnStockBin < PixiClient::Requests::Base
      attr_accessor :bin_name

      def initialize(bin_name)
        self.bin_name = bin_name
      end

      def api_method
        :pixi_get_items_on_stock_bin
      end

      def message
        { 'BinName' => bin_name }
      end
    end
  end
end
