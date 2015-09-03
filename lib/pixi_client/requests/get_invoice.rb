module PixiClient
  module Requests
    class GetInvoice < Base
      attr_accessor :invoice_number

      def initialize(invoice_number)
        self.invoice_number = invoice_number
      end

      def api_method
        :pixi_get_invoice
      end

      def message
        { 'InvoiceNr' => invoice_number }
      end
    end
  end
end
