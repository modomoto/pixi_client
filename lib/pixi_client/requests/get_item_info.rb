module PixiClient
  module Requests
    class GetItemInfo < Base
      include Itemable

      attr_accessor :item_id_key, :item_id

      def initialize(item_id_key, item_id)
        self.item_id_key = item_id_key
        self.item_id = item_id
      end

      def api_method
        :pixi_get_item_info
      end

    end
  end
end
