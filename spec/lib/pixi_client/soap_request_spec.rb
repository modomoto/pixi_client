require 'spec_helper'

describe PixiClient::Requests::Base do
  let(:savon_client) { double('savon_client') }
  subject { PixiClient::Requests::Base.new }

  before do
    allow(subject).to receive(:api_method).and_return(:fancy_soap_call)
    allow(subject).to receive(:message).and_return({ a: 1 })
    allow(subject).to receive(:client).and_return(savon_client)
  end

  describe '#call' do
    it 'should call the savon client with the corresponding params' do
      expect(savon_client).to(
        receive(:call).
          with(subject.api_method, attributes: { xmlns: PixiClient.configuration.endpoint }, message: subject.message).
          and_return(OpenStruct.new(body: {}))
      )
      allow(PixiClient::Response).to receive(:new)
      subject.call
    end

    it 'instantiates a PixiClient::Response instance' do
      allow(savon_client).to receive(:call).and_return(OpenStruct.new(body: {}))
      expect(PixiClient::Response).to receive(:new).with(subject.api_method, {})
      response = subject.call
    end
  end
end
