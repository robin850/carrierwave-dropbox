ENV["RACK_ENV"] = "test"

require 'rack/test'

require 'dummy_app'
require 'minitest/autorun'
require 'fileutils'

class Minitest::Test
  include Rack::Test::Methods

  def teardown
    FileUtils.rm_rf(File.expand_path("../public", __FILE__))
  end

  def app
    DummyApplication
  end

  def file_upload(image)
    path = File.expand_path("../fixtures/#{image}", __FILE__)
    Rack::Test::UploadedFile.new(path, "image/png")
  end

  def md5_data(data)
    md5 = Digest::MD5.new
    md5 << data
    md5.to_s
  end
end
