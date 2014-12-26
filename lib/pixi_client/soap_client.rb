require 'singleton'

module PixiClient
  class SoapClient
    class << self

      def call(service, request)
        client.call(service, request)
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
