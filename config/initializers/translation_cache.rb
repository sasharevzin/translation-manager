I18n.enforce_available_locales = false

host = case Rails.env
       when 'staging'
         'cache.labs.myplaydirect.com'
       when 'production'
         'cache.myplaydirect.com'
       else
         nil
       end

redis = Redis.new(host: host)
begin
  redis.ping
  # Need to keep the original backend to support the default translations
  # expected by Rails and its dependencies
  I18n.backend = I18n::Backend::Chain.new(I18n::Backend::KeyValue.new(redis), I18n.backend)
rescue Redis::CannotConnectError => e
  raise unless Rails.env.development?
  Rails.logger.warn("Translations will not be cached: #{e}")
end
