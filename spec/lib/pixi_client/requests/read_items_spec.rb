require 'spec_helper'

describe PixiClient::Requests::ReadItems do
  let(:created_from) { Time.now }
  let(:created_to) { Time.now }
  subject { PixiClient::Requests::ReadItems.new(created_from, created_to) }

  before do
    set_default_config
  end

  it { is_expected.to be_a_kind_of(PixiClient::Requests::Base) }

  describe '#api_method' do
    it 'should return :pixi_add_order_comment' do
      expect(subject.api_method).to eq :pixi_read_items
    end
  end

  describe 'call behaviour' do
    let(:expected_response) { double(body: { pixi_read_items_response: { pixi_read_items_result: sql_row_set_response_mock } }) }
    let(:double_client) { double }

    before do
      allow(subject).to receive(:client).and_return(double_client)
    end

    it 'should call the client with the appropriate parameters' do

      expected_from_string = created_from.strftime('%Y-%m-%dT%H:%M:%S.%3N')
      expected_to_string = created_to.strftime('%Y-%m-%dT%H:%M:%S.%3N')
      expected_message = {
        'CreateDateFrom' => expected_from_string,
        'CreateDateTo' => expected_to_string
      }

      expect(double_client).to receive(:call)
      .with(:pixi_read_items, attributes: { xmlns: PixiClient.configuration.endpoint }, message: expected_message)
      .and_return(expected_response)

      subject.call
    end

    it 'should instanciate an instance of Response with the response body' do
      expect(double_client).to receive(:call).and_return(expected_response)
      expect(PixiClient::Response).to receive(:new).with(:pixi_read_items, expected_response.body)
      subject.call
    end

    it 'should return an instance of Response' do
      expect(double_client).to receive(:call).and_return(expected_response)
      expect(subject.call).to be_an_instance_of(PixiClient::Response)
    end
  end

end
