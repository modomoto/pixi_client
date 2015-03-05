module PixiClient
  module Requests
    class ReadItems < Base
      attr_accessor :created_from, :created_to

      def initialize(created_from, created_to)
        self.created_from = created_from
        self.created_to = created_to
      end

      def api_method
        :pixi_read_items
      end

      def message
        {
          'CreateDateFrom' => created_from.strftime(TIME_STRING_FORMAT),
          'CreateDateTo' => created_to.strftime(TIME_STRING_FORMAT)
        }
      end
    end
  end
end
