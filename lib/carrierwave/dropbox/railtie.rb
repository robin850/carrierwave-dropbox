module CarrierWave
  module Dropbox
    class Railtie < Rails::Railtie
      rake_tasks do
        load "carrierwave/dropbox/authorize.rake"
      end
    end
  end
end
