require 'spec_helper'

describe PixiClient::Requests::GetOrderNrExternalByBoxNr do
  include Savon::SpecHelper

  let(:box_nr) { '12345' }
  subject { PixiClient::Requests::GetOrderNrExternalByBoxNr.new(box_nr: box_nr) }

  before(:all) do
    set_default_config
    savon.mock!
  end

  after(:all) { savon.unmock! }

  before do
    set_default_config
  end

  it { is_expected.to be_a_kind_of(PixiClient::Requests::Base) }

  describe '#api_method' do
    it 'should return :pixi_get_order_nr_external_by_box_nr' do
      expect(subject.api_method).to eq :pixi_get_order_nr_external_by_box_nr
    end
  end

  describe '#message' do
    it 'should return a hash in the form {\'BoxNr\' => <box_nr>}' do
      expect(subject.message).to eq('BoxNr' => box_nr)
    end
  end

  describe 'call behaviour' do
    before do
      savon.
        expects(:pixi_get_order_nr_external_by_box_nr).
        with(message: { 'BoxNr' => box_nr }).
        returns(File.read('spec/fixtures/get_order_nr_external_by_box_nr.xml')) # See file for data details
    end

    context 'when the box_nr exists', skip: true do
      it 'returns one row with the box_nr and the external order number' do
        result = subject.call
        expect(result.rows.size).to eq 1
        expect(result.rows.first.order_nr).to eq 10000
        expect(result.rows.first.order_nr_external).to eq '193498' # expected external number
      end
    end
  end
end
