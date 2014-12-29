module PixiClient
  module Requests
    class GetItemInfo < PixiClient::SoapRequest
      attr_accessor :item_id_key, :item_id

      def initialize(item_id_key, item_id)
        self.item_id_key = item_id_key
        self.item_id = item_id
      end

      def api_method
        :pixi_get_item_info
      end

      def message
        { item_id_key_to_param => item_id }
      end

      private

      def item_id_key_to_param
        case item_id_key
        when :eanupc then 'EANUPC'
        when :item_key then 'ItemKey'
        when :item_nr_int then 'ItemNrInt'
        when :item_nr_suppl then 'ItemNrSuppl'
        else fail('Not recognized item id key')
        end
      end

    end
  end
end
