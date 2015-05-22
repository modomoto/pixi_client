module PixiClient
  module Requests
    class ShippingGetPicklistHeaders < Base
      attr_accessor :location

      def initialize(location)
        self.location = location
      end

      def api_method
        :pixi_shipping_get_picklist_headers
      end

      def message
        { 'LocID' => location }
      end
    end
  end
end
