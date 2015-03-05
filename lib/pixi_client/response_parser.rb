require 'ostruct'

module PixiClient
  class ResponseParser
    attr_accessor :rows, :sql_messages, :response_body

    SQL_ROWSET1_SCHEMA_NS = 'urn:schemas-microsoft-com:sql:SqlRowSet1'

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
        self.rows << parse_row(unparsed_row)
      end
    end

    def unparsed_rows
      return [] if response_body[:sql_row_set].nil?
      return [] if response_body[:sql_row_set][:diffgram].nil?
      return [] if response_body[:sql_row_set][:diffgram][:sql_row_set1].nil?

      rowset = response_body[:sql_row_set][:diffgram][:sql_row_set1][:row]

      rowset.is_a?(Array) && rowset || [rowset]
    end

    def parse_row(row)
      OpenStruct.new.tap do |parsed_row|
        rowset_schema.each do |conversion|
          attr_name = conversion[:name].to_sym
          converted_value = send(conversion[:method], row[attr_name])
          parsed_row.send(:"#{attr_name}=", converted_value)
        end
      end
    end

    def rowset_schema
      if @rowset_schema.nil?
        schemas = response_body[:sql_row_set][:schema]
        schemas = [schemas] unless schemas.is_a?(Array)
        @rowset_schema = schemas.find { |schema| schema[:@target_namespace] == SQL_ROWSET1_SCHEMA_NS } || fail('Impossible to process response body: any schema definition found!')
        @rowset_schema = rowset_schema_to_conversion_hash(@rowset_schema)
      end

      @rowset_schema
    end

    def rowset_schema_to_conversion_hash(schema)
      field_list = schema[:element][:complex_type][:sequence][:element][:complex_type][:sequence][:element]
      field_list = [field_list] unless field_list.is_a?(Array)
      field_list.reduce([]) do |memo, field|
        conversion = {}
        conversion[:name] = underscore(field[:@name])

        if field[:@type]
          conversion[:method] = schema_type_to_conversion_method(field[:@type])
        else
          conversion[:method] = schema_type_to_conversion_method(field[:simple_type][:restriction][:@base])
        end

        memo << conversion
      end
    end

    def schema_type_to_conversion_method(schema_type)
      case(schema_type)
      when 'sqltypes:int' then :to_integer
      when 'sqltypes:datetime' then :to_time
      when 'sqltypes:bit' then :to_boolean
      when 'sqltypes:varchar' then :identity
      else :identity
      end
    end

    # Extract from Rails ActiveSupport::Inflector
    def underscore(word)
      word.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
    end

    def identity(value)
      value
    end

    def to_integer(value)
      value.to_i
    end

    def to_boolean(value)
      value.to_i == 1
    end

    def to_time(value)
      return '' if value.nil?

      Time.parse(value.to_s)
    end
  end
end
