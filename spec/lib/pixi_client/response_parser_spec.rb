require 'spec_helper'

describe PixiClient::ResponseParser do
  let(:ts) { Time.at(Time.now.to_i) } # HACK: avoid microseconds strange behaviour
  let(:response_body) { sql_row_set_response_mock(ts) }

  describe 'parsing' do
    subject(:parser) { PixiClient::ResponseParser.new(response_body) }

    it { is_expected.to be_an_instance_of(PixiClient::ResponseParser) }

    # examples modeled according to our mock (see spec/support/test_helpers)

    describe 'rows building' do
      before { parser.parse! }

      let(:first_row) { parser.rows.first }
      let(:second_row) { parser.rows.last }

      it 'should create two rows' do
        expect(parser.rows.length).to eq 2
      end

      it 'should set and convert integer attributes' do
        expect(first_row.int_attr).to eq 1
        expect(second_row.int_attr).to eq 2
      end

      it 'should set and convert datetime attributes' do
        expect(first_row.datetime).to eq ts
        expect(second_row.datetime).to eq ts
      end

      it 'should set and convert boolean attributes' do
        expect(first_row.boolean).to eq true
        expect(second_row.boolean).to eq false
      end

      it 'should set and convert string attributes' do
        expect(first_row.string_attr).to eq 'string1'
        expect(second_row.string_attr).to eq 'string2'
      end

      it 'should be able to process attributes with restriction description' do
        expect(first_row.string_attr_with_restriction).to eq 'restricted_string_1'
        expect(second_row.string_attr_with_restriction).to eq 'restricted_string_2'
      end
    end

    describe 'sql messages building' do
      before { parser.parse! }

      context 'only one message' do
        it 'should create an array of one message' do
          expect(parser.sql_messages.length).to eq 1
        end

        describe 'messages attributes building' do
          let(:sql_message) { parser.sql_messages.first }

          it 'should set the message class' do
            expect(sql_message.message_class).to eq '0'
          end

          it 'should set the message line number' do
            expect(sql_message.line_number).to eq '103'
          end

          it 'should set the message text' do
            expect(sql_message.message).to eq 'Warning: Null value is eliminated by an aggregate or other SET operation.'
          end

          it 'sholud set the message number' do
            expect(sql_message.number).to eq '8153'
          end

          it 'should set the procedure' do
            expect(sql_message.procedure).to eq 'pipiGetChangedItemStock'
          end

          it 'should set the message server' do
            expect(sql_message.server).to eq 'RGPSQL4'
          end

          it 'should set the message source' do
            expect(sql_message.source).to eq 'Microsoft-SQL/10.0'
          end

          it 'should set the message state' do
            expect(sql_message.state).to eq '1'
          end
        end
      end
    end
  end
end
