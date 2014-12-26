require 'spec_helper'

describe PixiClient do
  before do
    PixiClient.configure do |configuration|
      configuration.endpoint = 'endpoint'
      configuration.username = 'username'
      configuration.password = 'random-password'
    end
  end

  describe '::configuration' do
    it 'returns the configuration' do
      expect(PixiClient.configuration.endpoint).to eq 'endpoint'
      expect(PixiClient.configuration.username).to eq 'username'
      expect(PixiClient.configuration.password).to eq 'random-password'
    end
  end
end
