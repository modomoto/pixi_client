module PixiClient
  class Configuration
    attr_accessor :endpoint, :username, :password, :wsdl

    def wsdl_document
      wsdl || endpoint || raise(PixiClient::Error.new("A 'wsdl' or 'endpoint' must be configured"))
      wsdl ? wsdl : endpoint + '?wsdl'
    end

  end
end
