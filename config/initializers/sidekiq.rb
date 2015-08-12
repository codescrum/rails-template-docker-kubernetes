require 'sidekiq/api'
redis_url = Rails.env.development? ? 'redis://127.0.0.1:6379' : "redis://redis:6379"
redis_config = { url: redis_url, namespace: 'sidekiq' }

Sidekiq.configure_server do |config|
  config.redis = redis_config
end

Sidekiq.configure_client do |config|
  config.redis = redis_config
end
