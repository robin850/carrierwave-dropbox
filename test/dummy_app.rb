require 'sinatra'

require 'active_record'
require 'carrierwave'
require 'carrierwave/dropbox'
require 'carrierwave/orm/activerecord'

ActiveRecord::Base.raise_in_transactional_callbacks = true

ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3',
  database: ':memory:'
)

ActiveRecord::Schema.define do
  create_table :images do |t|
    t.string :attachment
  end
end

CarrierWave.configure do |config|
  config.dropbox_access_token        = ENV["ACCESS_TOKEN"]
end

class ImageUploader < CarrierWave::Uploader::Base
  storage :dropbox

  def store_dir
    "test/images/#{model.id}"
  end
end

class Image < ActiveRecord::Base
  mount_uploader :attachment, ImageUploader
end

class DummyApplication < Sinatra::Application
  post '/image/upload' do
    Image.create!(attachment: params[:attachment])
  end

  put '/image/edit/:id' do |id|
    Image.find(id).update(attachment: params[:attachment])
  end
end
