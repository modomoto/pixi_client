module PixiClient
  module Requests
    class SetStockMultiple < Base
      attr_accessor :item_updates_xml

      def initialize(item_updates_xml)
        self.item_updates_xml = item_updates_xml
      end

      def api_method
        :pixi_set_stock_multiple
      end

      def message
        { 'ParameterXML' => item_updates_xml }
      end
    end
  end
end
