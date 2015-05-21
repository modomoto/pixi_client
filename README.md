# PixiClient

PixiClient is a ruby client for the pixi SOAP API.

The intent behind it was to abstract all the SOAP and Microsoft SqlRowSet1 nasty details involved in the SOAP communication, letting the programmer to work with plain ruby objects, instead of XML response messages or hash objects.

It is also offers an easy way to include new requests to the API.

## Background

Do I need to read this section to use the gem? No at all. You can jump to Installtion if you feel like.

It's boring technical stuff about the implementation. But it could be useful if one day you run into troubles ;-)

The pixi SOAP API always responses with messages that follow the Microsoft SqlRowSet1 XML schema. The messages that follow this schema contains esentially three parts:
* A collection of warning and/or error messages
* A collection of field descriptors, that indicates how the rows of the response are structured
* A collection of rows containing the data

The pixi_client gem use the file descriptors to build ruby objects at runtime using OpenStruct.
The messages are also parsed and return as ruby objects using OpenStruct.

You can find the reference about the Microsoft SqlRowSet1 schema documentation at https://msdn.microsoft.com/en-us/library/ee320384(v=sql.105).aspx

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
end
```

### List of implemented calls

TODO

### Example of usage

All the requests has a common interface: the request to pixi is performed when the `call` method is invoked and it returns a response object.

The returned response object has two main methods:
* rows: an array of OpenStruct instances, where every instance has the attributes described in the API documentation. If the response is empty, it returns an empty array.
* messages: an array of OpenStruct instances, where every instance represent a warning or error message.

For example, supose you want to get the changed stock in the last 15 minutes using the API service pixiGetChangedItemsStock. According to the pixi documentation 

```ruby
PixiClient
  module Requests
    class GetChangedItemStock
```

### Extending it

We don't implement all the possible requests to the pixi SOAP API. Disappointed? You shouldn't.

We don't implement all, but we offer an easy way to add new requests without dealing with SOAP and Microsoft SqlRowSet1 dirty details.

To add a new request, you just need to extend `PixiClient::Requests::Base` and provide the following three methods:
* initialize: not mandatory, but useful to set the parameters your call needs.
* api_method: it must return a symbol with the name of the SOAP request following the lowercase separated by underscores naming convention. For example, if you want to call the service pixiGetStockBins the method should return `:pixi_get_stock_bins`.
* message: it must return a hash with the request parameters.

As example, let's implement pixiGetStockBins request. This request returns a list of all Bins available in the stock. It has three parameters, all optional:
* LocID: to filter bins by location ID.
* RowCount: Max rowcount to return. By default 0: return all.
* Start: Index of the row to start with. The default value is 0.

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
* Before to implement a new call, it is recommended that you install Wizdler Chrome Extesion. This extesion will let you to play in your browser easily with the pixi API. It is also really helpful when the pixi documentation is incomplete or has errors, what happens often.
* Consider that the order of the parameters is relevant. If the documentation lists the parameters in the order LocID, RowCount and Start, they should be provided in this order in the message hash (or omitted if they are optional). If you don't do this way, the API will complaint and return an error.


## Contributing

1. Fork it ( https://github.com/[my-github-username]/pixi_client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`). Here some tips how to write a good commit message: https://robots.thoughtbot.com/5-useful-tips-for-a-better-commit-message
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
