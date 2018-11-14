if File.file?('/.dockerenv')
  url = 'redis://redis:6379/0'
  Sidekiq.configure_server do |config|
    config.redis = { url: url }
  end
  
  Sidekiq.configure_client do |config|
    config.redis = { url: url }
  end
end


