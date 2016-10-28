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
  end

  describe '#endpoint=' do
    it 'sets the endpoint' do
      subject.endpoint = 'endpoint_url'
      expect(subject.endpoint).to eq 'endpoint_url'
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
