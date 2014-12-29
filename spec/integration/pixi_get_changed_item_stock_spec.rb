require 'spec_helper'
require 'savon'
require 'savon/mock/spec_helper'

describe 'pixiGetChangedItemStock' do
  include Savon::SpecHelper

  before(:all) do
    set_default_config
    savon.mock!
  end

  after(:all) { savon.unmock! }

  let(:christmas_time) { Time.parse('2014-12-25 00:00:00') }
  let(:request) { PixiClient::Requests::GetChangedItemStock.new(since: christmas_time) }

  context 'when the response is not empty' do
    before do
      savon.
        expects(:pixi_get_changed_item_stock).
        with(message: { 'Since' => christmas_time.strftime('%Y-%m-%dT%H:%M:%S.%3N') }).
        returns(File.read('spec/fixtures/pixi_get_changed_item_stock.xml')) # See file for data details
    end

    let(:response) { request.call }

    it 'responds with the expected 3 rows' do

      expected_rows = [
        OpenStruct.new(item_key: 92664,
          item_nr_int: '117843-102-8',
          eanupc: '0117843102089',
          item_nr_suppl: '6017 1550',
          physical_stock: 9,
          available_stock: 8,
          stock_change: 9,
          estimated_delivery: '',
          min_stock_qty: 0,
          enabled: true,
          open_supplier_order_qty: 0,
          update_date: Time.parse('2014-12-23T13:25:02 +00:00'),
          original_update_date: Time.parse('2014-12-23T13:25:02 +00:00'),
          bundle_item: false,
          row_nr: 1),

        OpenStruct.new(item_key: 2071,
        item_nr_int: '112852-704-1',
        eanupc: '0112852704019',
        item_nr_suppl: '857819996210',
        physical_stock: 17,
        available_stock: 17,
        stock_change: 17,
        estimated_delivery: '',
        min_stock_qty: 0,
        enabled: true,
        open_supplier_order_qty: 0,
        update_date: Time.parse('2014-12-23T15:00:01 +00:00'),
        original_update_date: Time.parse('2014-12-23T15:00:01 +00:00'),
        bundle_item: false,
        row_nr: 2),

        OpenStruct.new(item_key: 102032,
        item_nr_int: '207904-504-1',
        eanupc: '0207904504010',
        item_nr_suppl: 'W8538Q',
        physical_stock: 1,
        available_stock: 1,
        stock_change: 1,
        estimated_delivery: '',
        min_stock_qty: 0,
        enabled: true,
        open_supplier_order_qty: 0,
        update_date: Time.parse('2014-12-23T17:51:02 +00:00'),
        original_update_date: Time.parse('2014-12-23T17:51:02 +00:00'),
        bundle_item: false,
        row_nr: 3)
      ]

      expect(response.rows).to eq expected_rows
    end


  end
end
