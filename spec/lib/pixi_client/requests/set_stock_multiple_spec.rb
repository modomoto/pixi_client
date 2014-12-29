require 'spec_helper'

describe PixiClient::Requests::SetStockMultiple do
  let(:stock_update_xml) { set_stock_multiple_parameter_xml_mock }
  subject { PixiClient::Requests::SetStockMultiple.new(stock_update_xml) }

  before do
    set_default_config
  end

  it { is_expected.to be_a_kind_of(PixiClient::Requests::Base) }

  describe '#api_method' do
    it 'should return :get_changed_item_stock' do
      expect(subject.api_method).to eq :pixi_set_stock_multiple
    end
  end

  describe '#message' do
    it 'should return a hash in the form {\'ParameterXML\' => <xml_string>}' do
      expect(subject.message).to eq({ 'ParameterXML' => stock_update_xml })
    end
  end

  describe 'call behaviour' do
    let(:expected_response) { double(body: { pixi_set_stock_multiple_response: { pixi_set_stock_multiple_result: sql_row_set_response_mock } }) }
    let(:double_client) { double }

    before do
      allow(subject).to receive(:client).and_return(double_client)
    end

    it 'should call the client with the appropriate parameters' do
      expect(double_client).to receive(:call)
        .with(:pixi_set_stock_multiple, attributes: { xmlns: PixiClient.configuration.endpoint }, message: { 'ParameterXML' => stock_update_xml })
        .and_return(expected_response)

      subject.call
    end

    it 'should instanciate an instance of Response with the response body' do
      expect(double_client).to receive(:call).and_return(expected_response)
      expect(PixiClient::Response).to receive(:new).with(:pixi_set_stock_multiple, expected_response.body)
      subject.call
    end

    it 'should return an instance of Response' do
      expect(double_client).to receive(:call).and_return(expected_response)
      expect(subject.call).to be_an_instance_of(PixiClient::Response)
    end
  end

end
