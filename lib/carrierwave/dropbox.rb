require 'carrierwave'
require 'carrierwave/storage/dropbox'

require 'carrierwave/dropbox/version'
require 'carrierwave/dropbox/railtie' if defined?(Rails)

class CarrierWave::Uploader::Base
  add_config :dropbox_app_key
  add_config :dropbox_app_secret
  add_config :dropbox_access_token
  add_config :dropbox_access_token_secret
  add_config :dropbox_user_id
  add_config :dropbox_access_type

  configure do |config|
    config.storage_engines[:dropbox] = 'CarrierWave::Storage::Dropbox'
  end
end
