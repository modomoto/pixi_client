require 'open-uri'
require 'openssl'

namespace :pixi_client do
  desc 'Create .wsdl file'
  task :download_wsdl do
    OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
    config = PixiClient.configuration
    File.open('config/pixi_client.wsdl', "wb") do |wsdl_file|
      # the following "open" is provided by open-uri
      open(config.wsdl_document,
        http_basic_authentication: [config.username, config.password]) do |document|
          wsdl_file.write(document)
          puts 'file downloaded in config/pixi_client.wsdl'
      end
    end
  end

  task :install => [:download_wsdl] do
  end
end
