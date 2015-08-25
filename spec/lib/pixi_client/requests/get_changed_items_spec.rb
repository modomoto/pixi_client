require 'spec_helper'

describe PixiClient::Requests::GetChangedItems do
  let(:ts) { Time.parse('2014-12-25') }
  subject { PixiClient::Requests::GetChangedItems.new(since: ts) }

  before do
    set_default_config
  end

  it { is_expected.to be_a_kind_of(PixiClient::Requests::Base) }

  describe '#api_method' do
    it 'should return :get_changed_item_stock' do
      expect(subject.api_method).to eq :pixi_get_changed_items
    end
  end

  describe '#message' do
    context 'without row count' do
      it 'should return a hash in the form {\'Since\' => <timestamp>}' do
        expect(subject.message).to eq({ 'Since' => ts.strftime('%Y-%m-%dT%H:%M:%S.%3N') })
      end
    end
  end

  describe 'call behaviour' do
    let(:expected_response) { double(body: { pixi_get_changed_items_response: { pixi_get_changed_items_result: sql_row_set_response_mock } }) }
    let(:double_client) { double }

    before do
      allow(subject).to receive(:client).and_return(double_client)
    end

    it 'should call the client with the appropriate parameters' do
      expect(double_client).to receive(:call)
        .with(:pixi_get_changed_items, attributes: { xmlns: PixiClient.configuration.endpoint }, message: { 'Since' => ts.strftime('%Y-%m-%dT%H:%M:%S.%3N') })
        .and_return(expected_response)

      subject.call
    end

    it 'should instanciate an instance of Response with the response body' do
      expect(double_client).to receive(:call).and_return(expected_response)
      expect(PixiClient::Response).to receive(:new).with(:pixi_get_changed_items, expected_response.body)
      subject.call
    end

    it 'should return an instance of Response' do
      expect(double_client).to receive(:call).and_return(expected_response)
      expect(subject.call).to be_an_instance_of(PixiClient::Response)
    end
  end
end
