class Article < ActiveRecord::Base
  mount_uploader :image, ImageUploader
end
