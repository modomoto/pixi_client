require 'spec_helper'

describe PixiClient::Configuration do

  subject { PixiClient::Configuration.new }

  describe 'default values' do
    describe '#endpoint' do
      it 'should be nil' do
        expect(subject.endpoint).to be_nil
      end
    end

    describe '#wsdl' do
      it 'should be nil' do
        expect(subject.wsdl).to be_nil
      end
    end

    describe '#username' do
      it 'should be nil' do
        expect(subject.username).to be_nil
      end
    end

    describe '#password' do
      it 'should be nil' do
        expect(subject.password).to be_nil
      end
    end

    describe '#wsdl_document' do
      it 'should raise an error' do
        expect {
          subject.wsdl_document
          }.to raise_error(PixiClient::Error, "A 'wsdl' or 'endpoint' must be configured")
      end
    end
  end

  describe '#wsdl_document' do
    context 'when and endpoint is set' do
      it 'returns the remote wsdl document' do
        subject.endpoint = 'endpoint_url'
        subject.wsdl = nil
        expect(subject.wsdl_document).to eq('endpoint_url?wsdl')
      end
    end
    context 'when and wsdl file is set' do
      it 'returns the local wsdl document' do
        subject.endpoint = nil
        subject.wsdl = 'path/to/endpoint.xml'
        expect(subject.wsdl_document).to eq('path/to/endpoint.xml')
      end
    end
    context 'when no wsdl or file is set' do
      it 'raises an error' do
        subject.endpoint = nil
        subject.wsdl = nil
        expect {
          subject.wsdl_document
          }.to raise_error(PixiClient::Error, "A 'wsdl' or 'endpoint' must be configured")
      end
    end
  end

  describe '#username=' do
    it 'sets the username' do
      subject.username = 'username'
      expect(subject.username).to eq 'username'
    end
  end

  describe '#wsdl=' do
    it 'sets the wsdl' do
      subject.wsdl = 'wsdl_set'
      expect(subject.wsdl).to eq 'wsdl_set'
    end
  end

  describe '#password=' do
    it 'sets the password' do
      subject.password = 'random-password'
      expect(subject.password).to eq 'random-password'
    end
  end
end
