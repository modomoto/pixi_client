module PixiClient
  module Requests
    class GetChangedItemStock < Base

      attr_accessor :since, :row_count

      def initialize(opts)
        self.since = opts[:since]
        self.row_count = opts[:row_count]
      end

      def api_method
        :pixi_get_changed_item_stock
      end

      def message
        { 'Since' => since.strftime(TIME_STRING_FORMAT) }.tap do |opts|
          opts['RowCount'] = row_count unless row_count.nil?
        end
      end
    end
  end
end
