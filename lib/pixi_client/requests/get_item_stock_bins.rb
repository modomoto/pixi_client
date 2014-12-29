module PixiClient
  module Requests
    class GetItemStockBins < PixiClient::SoapRequest
      attr_accessor :item_id_key, :item_id

      def initialize(item_id_key, item_id)
        self.item_id_key = item_id_key
        self.item_id = item_id
      end

      def api_method
        :pixi_get_item_stock_bins
      end

      def message
        { item_id_key_to_param => item_id }
      end

      private

      def item_id_key_to_param
        case item_id_key
        when :ean then 'EAN'
        when :item_key then 'ItemKey'
        when :item_nr_int then 'ItemNrInt'
        when :item_nr_suppl then 'ItemNrSuppl'
        else fail('Not recognized item id key')
        end
      end
    end
  end
end
