module PixiClient
  module Requests
    class GetItemStockBins < Base
      include Itemable

      attr_accessor :item_id_key, :item_id

      def initialize(item_id_key, item_id)
        self.item_id_key = item_id_key
        self.item_id = item_id
      end

      def api_method
        :pixi_get_item_stock_bins
      end
    end
  end
end
