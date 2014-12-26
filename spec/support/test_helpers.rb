module TestHelpers
  def set_default_config
    PixiClient.configure do |config|
      config.endpoint = 'https://rgpsql4.api.madgeniuses.net/pixiMMO/'
      config.username = 'pixiMMO'
      config.password = 'dFFuYgr@XZqpM$hn_}'
    end
  end
end
