module PixiClient
  class SoapRequest
    class << self
      def call(service, message = {})
        Response.new(client.call(service, message))
      end

      private

      def client
        @client ||= Savon.client(
          wsdl: PixiClient.configuration.endpoint,
          ssl_verify_mode: :none,
          basic_auth: [PixiClient.configuration.username, PixiClient]
        )
      end
    end
  end
end
