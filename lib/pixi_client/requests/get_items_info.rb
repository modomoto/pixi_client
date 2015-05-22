module PixiClient
  module Requests
    class GetItemsInfo < Base
      attr_accessor :ean_codes, :location_id

      def initialize(ean_codes, location_id)
        self.ean_codes = ean_codes
        self.location_id = location_id
      end

      def api_method
        :pixi_get_item_info
      end

      def message
        { 'LocID' => location_id, 'ItemXML' => xml_message }
      end

      def xml_message
        builder = Builder::XmlMarkup.new

        builder.ITEMS do
          ean_codes.each do |code|
            builder.ITEM do
              builder.EAN code
            end
          end
        end

        builder.target!
      end
    end
  end
end
