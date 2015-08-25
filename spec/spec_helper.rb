require 'pry'
require 'pixi_client'

Dir[('./spec/support/**/*.rb')].each {|f| require f}

require File.join('lib', 'pixi_client', 'requests', 'itemable_shared_examples')

RSpec.configure do |config|
  config.filter_run_excluding skip: true
  config.include TestHelpers
end
