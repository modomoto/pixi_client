require 'spec_helper'

describe PixiClient::Requests::GetStockByBin do
  let(:loc_id) { '001' }
  subject { PixiClient::Requests::GetStockByBin.new(loc_id) }

  before do
    set_default_config
  end

  it { is_expected.to be_a_kind_of(PixiClient::Requests::Base) }

  describe '#api_method' do
    it 'should return :pixi_get_stock_bins' do
      expect(subject.api_method).to eq :pixi_get_stock_bins
    end
  end

  describe 'call behaviour' do
    let(:expected_response) { double(body: { pixi_get_stock_bins_response: { pixi_get_stock_bins_result: sql_row_set_response_mock } }) }
    let(:double_client) { double }

    before do
      allow(subject).to receive(:client).and_return(double_client)
    end

    it 'should call the client with the appropriate parameters' do
      expect(double_client).to receive(:call)
      .with(:pixi_get_stock_bins, attributes: { xmlns: PixiClient.configuration.endpoint }, message: { 'LocID' => loc_id})
      .and_return(expected_response)

      subject.call
    end

    it 'should instanciate an instance of Response with the response body' do
      expect(double_client).to receive(:call).and_return(expected_response)
      expect(PixiClient::Response).to receive(:new).with(:pixi_get_stock_bins, expected_response.body)
      subject.call
    end

    it 'should return an instance of Response' do
      expect(double_client).to receive(:call).and_return(expected_response)
      expect(subject.call).to be_an_instance_of(PixiClient::Response)
    end
  end

end
