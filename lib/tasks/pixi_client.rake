require 'open-uri'
require 'openssl'

namespace :pixi_client do
  desc 'Create the file config/pixi_client.wsdl'
  task :download_wsdl do
    config = YAML.load_file(File.join([Rails.root, 'config', 'pixi.yml']))[Rails.env]

    OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE # needed due to the context

    File.open('config/pixi_client.wsdl', "wb") do |wsdl_file|
      # the following "open" is provided by open-uri
      open(config['url'] + '?wsdl',
        http_basic_authentication: [config['username'], config['password']]) do |document|
          wsdl_file.write(document.read)
          puts 'file downloaded in config/pixi_client.wsdl'
      end
    end

  end

  task :install => [:download_wsdl] do
  end
end
