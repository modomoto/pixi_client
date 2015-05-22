module PixiClient
  module Requests
    class GetUnshippableOrders < Base
      attr_accessor :location

      def initialize(location)
        self.location = location
      end

      def api_method
        :pixi_report_get_unshippable_orders
      end

      def message
        { 'ViewDetails' => 1, 'IncludeCustLock' => 0, 'LocID' => location }
      end
    end
  end
end
