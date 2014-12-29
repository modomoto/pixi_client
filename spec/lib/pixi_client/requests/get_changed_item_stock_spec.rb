require 'spec_helper'

describe PixiClient::Requests::GetChangedItemStockRequest do
  let(:ts) { Time.parse('2014-12-25 00:00:00') }
  subject { PixiClient::Requests::GetChangedItemStockRequest.new(since: ts) }

  before do
    set_default_config
  end

  it { is_expected.to be_a_kind_of(PixiClient::SoapRequest) }

  describe '#response_class' do
    it 'should return PixiClient::Responses::GetChangedItemStockResponse' do
      expect(subject.response_class).to eq PixiClient::Responses::GetChangedItemStockResponse
    end
  end

  describe '#api_method' do
    it 'should return :get_changed_item_stock' do
      expect(subject.api_method).to eq :get_changed_item_stock
    end
  end

  describe '#message' do
    context 'without row count' do
      it 'should return a hash in the form {\'Since\' => <timestamp>}' do
        expect(subject.message).to eq({ 'Since' => ts.strftime('%Y-%m-%dT%H:%M:%S.%3N') })
      end
    end

    context 'with row count' do
      it 'should return a hash in the form {\'Since\' => <timestamp>, \'RowCount\' => <count>}' do
        subject.row_count = 100
        expect(subject.message).to eq({ 'Since' => ts.strftime('%Y-%m-%dT%H:%M:%S.%3N'), 'RowCount' => 100})
      end
    end
  end

  describe 'call behaviour' do
    let(:expected_response) { double(body: {}) }
    let(:double_client) { double }

    before do
      allow(subject).to receive(:client).and_return(double_client)
    end

    it 'should call the client with the appropriate parameters' do
      expect(double_client).to receive(:call)
        .with(:get_changed_item_stock, attributes: { xmlns: PixiClient.configuration.endpoint }, message: { 'Since' => ts.strftime('%Y-%m-%dT%H:%M:%S.%3N') })
        .and_return(expected_response)

      subject.call
    end

    it 'should instanciate an instance of GetChangedItemStockResponse with the response body' do
      expect(double_client).to receive(:call).and_return(expected_response)
      expect(PixiClient::Responses::GetChangedItemStockResponse).to receive(:new).with(expected_response.body)
      subject.call
    end

    it 'should return an instance of GetChangedItemStockResponse' do
      expect(double_client).to receive(:call).and_return(expected_response)
      expect(subject.call).to be_an_instance_of(PixiClient::Responses::GetChangedItemStockResponse)
    end
  end
end
