module PixiClient
  class Response
    attr_accessor :pixi_response, :messages, :body

    def initialize(pixi_response)
      self.pixi_response = pixi_response
    end

    def succeed?
      self.pixi_response.success?
    end

    def body
    end
  end
end
