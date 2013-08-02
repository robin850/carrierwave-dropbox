require 'spec_helper'

describe CarrierWave::Uploader::Base do
  it "has the dropbox storage" do
    described_class.configure do |c|
      c.storage_engines.should have_key(:dropbox)
    end
  end

  it "should respond to the different configuration methods" do
    described_class.should respond_to(:dropbox_app_key)
    described_class.should respond_to(:dropbox_app_secret)
    described_class.should respond_to(:dropbox_access_token)
    described_class.should respond_to(:dropbox_access_token_secret)
    described_class.should respond_to(:dropbox_user_id)
    described_class.should respond_to(:dropbox_access_type)
  end
end
