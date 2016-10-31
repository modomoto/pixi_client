# PixiClient

PixiClient is a ruby client for the pixi SOAP API.

The intent behind it was to abstract all the SOAP and nasty Microsoft SqlRowSet1 details involved in the SOAP communication, letting the programmer to work with plain ruby objects, instead of XML response messages or hash objects.

It also offers an easy way to include new requests to the API.

## Background

Do I need to read this section to use the gem? No, at all. You can jump to Installation if you feel like it.

It's boring technical stuff about the implementation, but it could be useful if one day you run into troubles. ;-)

The pixi SOAP API always responses with messages that follow the Microsoft SqlRowSet1 XML schema. The messages that follow this schema contains esentially three parts:
* A collection of warning and/or error messages
* A collection of field descriptors, that indicates how the rows of the response are structured
* A collection of rows containing the data

The pixi_client gem uses the file descriptors to build ruby objects at runtime using OpenStruct.
The messages are also parsed and returned as Ruby objects using OpenStruct.

See also the [reference about the Microsoft SqlRowSet1 schema documentation](https://msdn.microsoft.com/en-us/library/ee320384(v=sql.105).aspx).

## Requirements

The gem has been tested with Ruby versions >= 2.1.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pixi_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pixi_client

## Usage

### Configuration

#### Rails

config/initializers/pixi_client.rb

```ruby
PixiClient.configure do |config|
  config.endpoint = <your_pixi_endpoing_url>
  config.username = <your_pixi_username>
  config.password = <your_pixi_password>
  config.wsdl     = <path/to/wdsl_document.wsdl>
end
```

### Example of usage

To have a list of the implemented requests, have a look to the lib/requests folder.

All the requests have a common interface: the request to pixi is performed when the `call` method is invoked and it returns a response object.

The returned response object has two main methods:
* rows: an array of OpenStruct instances, where every instance has the attributes described in the API documentation with the data type described in the XML schema. If the response is empty, it returns an empty array.
* messages: an array of OpenStruct instances, where every instance represent a warning or error message.

For example, suppose you want to get the changed stock in the last 15 minutes using the API service `pixiGetChangedItemsStock` (`PixiClient::Requests::GetChangedItemStock`).

According to the pixi documentation the response is a collection of rows with the following columns:
* ItemKey
* ItemNrInt
* EANUPC
* ItemNrSuppl
* PhysicalStock
* AvailableStock
* StockChange
* EstimatedDelivery
* MinStockQty
* Enabled
* OpenSupplierOrderQTY
* UpdateDate
* OriginalUpdateDate
* BundleItem
* RowNr

```ruby
response = PixiClient::Requests::GetChangedItemStock.new(since: 15.minutes.ago).call

single_row = response.rows.first

# Single row is an OpenStruct with the following ruby attributes:
# => item_key
# => item_nr_int
# => eanup
# => item_nr_suppl
# => physical_stock
# => available_stock
# => stock_change
# => estimated_delivery
# => min_stock_qty
# => enabled
# => open_supplier_order_qty
# => update_date
# => original_update_date
# => bundle_item
# => row_nr

```
### Extending it

We don't implement all the possible requests to the pixi SOAP API. Disappointed? You shouldn't.

We don't implement all, but we offer an easy way to add new requests without dealing with SOAP and Microsoft SqlRowSet1 dirty details.

To add a new request, you just need to extend `PixiClient::Requests::Base` and provide the following three methods:
* `initialize`: not mandatory, but useful to set the parameters your call needs.
* `api_method`: it must return a symbol with the name of the SOAP request following the lowercase separated by underscores naming convention. For example, if you want to call the service pixiGetStockBins the method should return `:pixi_get_stock_bins`.
* `message`: it must return a hash with the request parameters.

As example, let's implement `pixiGetStockBins` request. This request returns a list of all Bins available in the stock. It has three parameters, all optional:
* `LocID`: to filter bins by location ID.
* `RowCount`: Max rowcount to return. By default 0: return all.
* `Start`: Index of the row to start with. The default value is 0.

```ruby
class GetStockBins < PixiClient::Requests::Base
  attr_accessor :loc_id, :row_count, :start

  def initialize(params = {})
    self.loc_id = params[:loc_id]
    self.row_count = params[:row_count] || 0
    self.start = params[:start] || 0
  end

  def api_method
    :pixi_get_stock_bins
  end

  def message
    message = {}
    message['LocID'] = loc_id if loc_id.present?
    message.merge({
      'RowCount' => row_count,
      'Start' => start
    })
  end
end # That's it!

# Let's have fun printting out all our bins :-)
response = GetStockBins.new.call
response.rows.each do |bin|
  puts "#{bin.bin_name}"
end
```

A couple of tips when you are adding new requests:
* Before you implement a new call, it is recommended that you install [Wizdler Chrome Extension](https://chrome.google.com/webstore/detail/wizdler/oebpmncolmhiapingjaagmapififiakb). This extesion will let you to play in your browser easily with the pixi API. It is also really helpful when the pixi documentation is incomplete or has errors, what happens often.
* Consider that the order of the parameters is relevant. If the documentation lists the parameters in the order `LocID`, `RowCount` and `Start`, they should be provided in this order in the message hash (or omitted if they are optional). If you don't do this way, the API will complaint and return an error.


## Contributing

1. Fork it ( https://github.com/[my-github-username]/pixi_client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`). Here some tips how to write a good commit message: https://robots.thoughtbot.com/5-useful-tips-for-a-better-commit-message
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
