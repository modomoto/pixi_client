module PixiClient
  module Requests
    module Itemable

      def message
        { item_id_key_to_param => item_id }
      end

      private

      def item_id_key_to_param
        case item_id_key
        when :ean then 'EAN'
        when :eanupc then 'EANUPC'
        when :item_key then 'ItemKey'
        when :item_nr_int then 'ItemNrInt'
        when :item_nr_suppl then 'ItemNrSuppl'
        else fail('Not recognized item id key')
        end
      end

    end
  end
end
