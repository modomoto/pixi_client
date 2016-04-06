module PixiClient
  module Requests
    class GetItemStock < Base
      include Itemable

      attr_accessor :item_id_key, :item_id

      def initialize(item_id_key, item_id)
        self.item_id_key = item_id_key
        self.item_id = item_id
      end

      def message
        { item_id_key_to_param => item_id, 'LocationStock' => 1}
      end

      def api_method
        :pixi_get_item_stock
      end
    end
  end
end

