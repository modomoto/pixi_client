require 'spec_helper'
require 'savon'
require 'savon/mock/spec_helper'

describe 'pixiGetChangedItemStock' do
  before(:all) { savon.mock! }
  after(:all) { savon.unmock! }

  context 'when the response is not empty' do
    # before do
    #   savon.expects(:pixi_get_changed_item_stock).with(message: { 'Since' => ts.strftime('%Y-%m-%dT%H:%M:%S.%3N') }).returns(File.read('spec/fixtures/pixi_get_changed_item_stock.xml'))
    # end
    #
    # let(:response) { subject.call }
    #
    # it 'should build a response with the data' do
    # end
  end
end
