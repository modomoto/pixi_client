require 'rails'

module PixiClientRailtie
  class Railtie < Rails::Railtie
    railtie_name :pixi_client

    rake_tasks do
      load 'tasks/pixi_client.rake'
    end
  end
end
