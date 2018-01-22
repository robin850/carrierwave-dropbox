require 'carrierwave'
require 'carrierwave/storage/dropbox'

require 'carrierwave/dropbox/version'

class CarrierWave::Uploader::Base
  add_config :dropbox_access_token

  configure do |config|
    config.storage_engines[:dropbox] = 'CarrierWave::Storage::Dropbox'
  end
end
