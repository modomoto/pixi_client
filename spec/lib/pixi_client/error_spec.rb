require 'spec_helper'

describe PixiClient::Error do

  subject { PixiClient::Error.new }

  it 'should accept a message' do
    begin
      raise PixiClient::Error.new('Something happend')
    rescue => e
      expect(e.class).to eq(PixiClient::Error)
      expect(e.message).to eq('Something happend')
    end
  end
end
