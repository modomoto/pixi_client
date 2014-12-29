require 'spec_helper'

describe PixiClient::SoapRequest do
  let(:savon_client) { double('savon_client') }

  before do
    allow(PixiClient::SoapRequest).to receive(:client).and_return(savon_client)
  end

  describe '::call' do
    let(:service) { service = :fancy_soap_call }
    let(:message) { { a: 1 } }

    it 'should call the savon client with the corresponding params' do
      expect(savon_client).to receive(:call).with(service, message)
      PixiClient::SoapRequest.call(service, message)
    end

    it 'returns a PixiClient::Response object' do
      allow(savon_client).to receive(:call)
      response = PixiClient::SoapRequest.call(service, message)
      expect(response).to be_an_instance_of(PixiClient::Response)
    end
  end
end
