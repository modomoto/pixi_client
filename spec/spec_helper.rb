require 'pry'
require 'pixi_client'

Dir[('./spec/support/**/*.rb')].each {|f| require f}

RSpec.configure do |config|
  config.include TestHelpers
end
