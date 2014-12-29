module TestHelpers
  def set_default_config
    PixiClient.configure do |config|
      config.endpoint = 'https://rgpsql4.api.madgeniuses.net/pixiMMO/'
      config.username = 'pixiMMO'
      config.password = 'dFFuYgr@XZqpM$hn_}'
    end
  end

  def set_stock_multiple_parameter_xml_mock
    <<-EOS
      <ITEMSTOCK>
        <ITEM>
          <EANUPC>12345</EANUPC>
          <INVBINS>
            <INVBIN>
              <BINNAME>A</BINNAME>
              <STOCK>5</STOCK>
            </INVBIN>
          </INVBINS>
        </ITEM>
      </ITEMSTOCK>
    EOS
  end

  def sql_row_set_response_mock(ts = Time.now)
    { :sql_message =>
        {
          :class => "0",
          :line_number => "103",
          :message => "Warning: Null value is eliminated by an aggregate or other SET operation.",
          :number => "8153",
          :procedure => "pipiGetChangedItemStock",
          :server => "RGPSQL4",
          :source => "Microsoft-SQL/10.0",
          :state => "1",
          :"@xsi:type" => "sqlmessage:SqlMessage"
        },
      :sql_row_set => {
        :schema => [
          {
            :simple_type => [
              {
                :restriction => { :@base => "xsd:int" },
                :@name => "int"
              },
              {
                :restriction => { :@base => "xsd:string" },
                :@name => "varchar"
              },
              {
                :restriction => {
                  :pattern => { :@value => "((000[1-9])|(00[1-9][0-9])|(0[1-9][0-9]{2})|([1-9][0-9]{3}))-((0[1-9])|(1[012]))-((0[1-9])|([12][0-9])|(3[01]))T(([01][0-9])|(2[0-3]))(:[0-5][0-9]){2}(\\.[0-9]{2}[037])?" },
                  :min_inclusive => { :@value => "1753-01-01T00:00:00.000" },
                  :max_inclusive => { :@value=>"9999-12-31T23:59:59.997" },
                  :@base => "xsd:dateTime"
                },
                :@name => "datetime"
              },
              {
                :restriction => { :@base => "xsd:boolean" },
                :@name => "bit"
              }
            ],
            :"@xmlns:xsd" => "http://www.w3.org/2001/XMLSchema",
            :@target_namespace => "http://schemas.microsoft.com/sqlserver/2004/sqltypes"
          },
          {
            :import => { :@namespace => "http://schemas.microsoft.com/sqlserver/2004/sqltypes" },
            :element => {
              :complex_type => {
                :sequence => {
                  :element => {
                    :complex_type => {
                      :sequence => {
                        :element => [
                          { :@name => "int_attr", :@type => "sqltypes:int" },
                          { :@name => "DATETIME", :@type => "sqltypes:datetime", :@min_occurs => "0"},
                          { :@name => "boolean", :@type => "sqltypes:bit", :@min_occurs => "0"},
                          { :@name => "StringAttr", :@type => "sqltypes:varchar"},
                          {
                            :simple_type => {
                              :restriction => {
                                :max_length => { :@value => "13" },
                                :@base => "sqltypes:varchar",
                                :"@sqltypes:locale_id" => "1033",
                                :"@sqltypes:sql_compare_options" => "IgnoreCase IgnoreKanaType IgnoreWidth"
                              }
                            },
                            :@name => "StringAttrWithRestriction",
                            :@min_occurs=>"0"
                          },
                        ]
                      }
                    },
                    :@name => "row",
                    :@min_occurs => "0",
                    :@max_occurs => "unbounded"
                  }
                }
              },
              :@name => "SqlRowSet1",
              :"@msdata:is_data_set" => "true",
              :"@msdata:data_set_namespace" => "urn:schemas-microsoft-com:sql:SqlDataSet",
              :"@msdata:data_set_name" => "SqlDataSet"
            },
            :@xmlns=>"",
            :"@xmlns:xsd" => "http://www.w3.org/2001/XMLSchema",
            :"@xmlns:sqltypes" => "http://schemas.microsoft.com/sqlserver/2004/sqltypes",
            :@target_namespace => "urn:schemas-microsoft-com:sql:SqlRowSet1",
            :@element_form_default => "qualified"
          }
        ],
        :diffgram => {
          :sql_row_set1 => {
            :row => [
              { :int_attr => '1', :datetime => ts, :boolean => '1', :string_attr => 'string1', :string_attr_with_restriction => 'restricted_string_1' },
              { :int_attr => '2', :datetime => ts, :boolean => '0', :string_attr => 'string2', :string_attr_with_restriction => 'restricted_string_2' }
            ],
            :@xmlns => "urn:schemas-microsoft-com:sql:SqlRowSet1"
          },
          :"@xmlns:diffgr" => "urn:schemas-microsoft-com:xml-diffgram-v1"
        },
        :"@xsi:type" => "sqlsoaptypes:SqlRowSet",
        :"@msdata:use_data_set_schema_only" => "true",
        :"@msdata:udt_column_value_wrapped" => "true"
      },
      :sql_result_code => "0",
      :@xmlns => ""
    }
  end
end
