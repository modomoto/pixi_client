module PixiClient
  class SoapRequest
    TIME_STRING_FORMAT = '%Y-%m-%dT%H:%M:%S.%3N'

    def call
      response = client.call(api_method, attributes: { xmlns: PixiClient.configuration.endpoint }, message: message)
      Response.new(api_method, response.body)
    end

    private

    def client
      @client ||= Savon.client(
        wsdl: PixiClient.configuration.endpoint + '?wsdl',
        ssl_verify_mode: :none,
        basic_auth: [PixiClient.configuration.username, PixiClient.configuration.password]
      )
    end
  end
end
