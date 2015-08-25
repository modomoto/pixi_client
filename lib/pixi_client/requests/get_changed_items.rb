module PixiClient
  module Requests
    class GetChangedItems < Base
      attr_accessor :since

      def initialize(opts)
        self.since = opts[:since]
      end

      def api_method
        :pixi_get_changed_items
      end

      def message
        { 'Since' => since.strftime(TIME_STRING_FORMAT) }
      end
    end
  end
end