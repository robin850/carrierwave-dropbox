require 'test_helper'

class CarrierWaveUploaderBaseTest < Minitest::Test
  def setup
    @object = CarrierWave::Uploader::Base
  end

  def test_dropbox_storage
    @object.configure do |c|
      assert c.storage_engines.key?(:dropbox)
    end
  end

  def test_respond_to_configuration_methods
    assert @object.respond_to?(:dropbox_app_key)
    assert @object.respond_to?(:dropbox_app_secret)
    assert @object.respond_to?(:dropbox_access_token)
    assert @object.respond_to?(:dropbox_access_token_secret)
    assert @object.respond_to?(:dropbox_user_id)
    assert @object.respond_to?(:dropbox_access_type)
  end
end
