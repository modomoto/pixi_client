require 'spec_helper'

shared_examples 'itemable' do
  before do
    subject.item_id = '12345'
  end

  describe '#message' do

    context 'item_id_key is :ean' do
      it 'returns {\'EAN\' => \'12345\'}' do
        subject.item_id_key = :ean
        expect(subject.message).to eq({ 'EAN' => '12345' })
      end
    end

    context 'item_id_key is :eanupc' do
      it 'returns {\'EANUPC\' => \'12345\'}' do
        subject.item_id_key = :eanupc
        expect(subject.message).to eq({ 'EANUPC' => '12345' })
      end
    end

    context 'item_id_key is :item_key' do
      it 'returns {\'ItemKey\' => \'12345\'}' do
        subject.item_id_key = :item_key
        expect(subject.message).to eq({ 'ItemKey' => '12345' })
      end
    end

    context 'item_id_key is :item_nr_int' do
      it 'returns {\'ItemNrInt\' => \'12345\'}' do
        subject.item_id_key = :item_nr_int
        expect(subject.message).to eq({ 'ItemNrInt' => '12345' })
      end
    end

    context 'item_id_key is :item_nr_suppl' do
      it 'returns {\'ItemNrSuppl\' => \'12345\'}' do
        subject.item_id_key = :item_nr_suppl
        expect(subject.message).to eq({ 'ItemNrSuppl' => '12345' })
      end
    end

    context 'the item id key is not allowed' do
      it 'raises an exception' do
        subject.item_id_key = :random_key
        expect { subject.message }.to raise_error
      end
    end
  end
end
