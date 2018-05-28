require 'ostruct'

module PixiClient
  class ResponseParser
    attr_accessor :rows, :sql_messages, :response_body

    def initialize(response_body)
      self.response_body = response_body
      self.rows = []
      self.sql_messages = []
    end

    def parse!
      parse_sql_messages
      parse_rowset
    end

    private

    def parse_sql_messages
      unparsed_messages.each do |unparsed_message|
        self.sql_messages << parse_sql_message(unparsed_message)
      end
    end

    def unparsed_messages
      unless @unparsed_messages
        @unparsed_messages = response_body[:sql_message] || []
        @unparsed_messages = [@unparsed_messages] unless @unparsed_messages.is_a?(Array)
      end

      @unparsed_messages
    end

    def parse_sql_message(unparsed_message)
      OpenStruct.new.tap do |parsed_message|
        parsed_message.message_class = unparsed_message[:class]
        [:line_number, :message, :number, :procedure, :server, :source, :state].each do |attr|
          parsed_message.send(:"#{attr}=", unparsed_message[attr])
        end
      end
    end

    def parse_rowset
      unparsed_rows.each do |unparsed_row|
        self.rows << OpenStruct.new(unparsed_row)
      end
    end

    def unparsed_rows
      return [] if response_body[:sql_row_set].nil?
      return [] if response_body[:sql_row_set][:diffgram].nil?
      return [] if response_body[:sql_row_set][:diffgram][:sql_row_set1].nil?

      rowset = response_body[:sql_row_set][:diffgram][:sql_row_set1][:row]

      rowset.is_a?(Array) && rowset || [rowset]
    end
  end
end
