module PixiClient
  module Requests
    class ShippingGetPicklistDetails < Base
      attr_accessor :picklist_key

      def initialize(picklist_key)
        self.picklist_key = picklist_key
      end

      def api_method
        :pixi_shipping_get_picklist_details
      end

      def message
        { 'PicklistKey' => picklist_key }
      end
    end
  end
end
