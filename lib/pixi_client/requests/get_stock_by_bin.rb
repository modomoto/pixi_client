module PixiClient
  module Requests
    class GetStockByBin < PixiClient::Requests::Base
      attr_accessor :loc_id

      def initialize(loc_id)
        self.loc_id = loc_id
      end

      def api_method
        :pixi_get_stock_bins
      end

      def message
        { 'LocID' => loc_id }
      end
    end
  end
end
