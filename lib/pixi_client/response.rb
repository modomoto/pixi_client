module PixiClient
  class Response
    attr_accessor :rows, :sql_messages

    def initialize(api_method, response_body)
      parser = PixiClient::ResponseParser.new(response_body[:"#{api_method}_response"][:"#{api_method}_result"])
      parser.parse!
      self.rows = parser.rows
      self.sql_messages = parser.sql_messages
    end
  end
end
