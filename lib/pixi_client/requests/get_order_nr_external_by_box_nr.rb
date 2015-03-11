module PixiClient
  module Requests
    class GetOrderNrExternalByBoxNr < Base
      attr_accessor :box_nr

      def initialize(opts)
        self.box_nr = opts[:box_nr]
      end

      def api_method
        :pixi_get_order_nr_external_by_box_nr
      end

      def message
        { 'BoxNr' => box_nr }
      end
    end
  end
end
