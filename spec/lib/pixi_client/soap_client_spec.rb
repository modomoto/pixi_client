require 'spec_helper'

describe PixiClient::SoapClient do

  describe '#instance' do
    it 'is singleton' do
      client_a = PixiClient::SoapClient.instance
      client_b = PixiClient::SoapClient.instance

      expect(client_a).to be client_b
    end
  end
end
