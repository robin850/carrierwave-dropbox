# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "foo/#{model.class.to_s.pluralize.underscore}/#{mounted_as}/#{model.id}"
  end

  storage :dropbox

  version :thumbnail do
    process resize_to_fit: [300, 200]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
