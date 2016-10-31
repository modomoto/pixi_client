require 'savon'

module PixiClient
  module Requests
    class Base
      TIME_STRING_FORMAT = '%Y-%m-%dT%H:%M:%S.%3N'
      FIVE_MINUTES = 5 * 60

      def call
        response = client.call(api_method, attributes: { xmlns: PixiClient.configuration.endpoint }, message: message)
        Response.new(api_method, response.body)
      end

      private

      def client
        @client ||= Savon.client(
          wsdl: PixiClient.configuration.wsdl_document,
          open_timeout: 300,
          read_timeout: 300,
          ssl_verify_mode: :none,
          basic_auth: [PixiClient.configuration.username, PixiClient.configuration.password]
        )
      end
    end
  end
end
