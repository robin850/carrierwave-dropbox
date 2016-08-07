require 'test_helper'

class FileUploadTest < Minitest::Test
  def test_uploading_a_simple_file
    original_count = Image.count

    post "/image/upload", attachment: file_upload('rails.png')

    assert last_response.ok?
    assert_equal 1, (Image.count - original_count)
    refute Image.last.attachment.url.empty?
  end


  def test_upload_image_editing
    post "/image/upload", attachment: file_upload('ruby.png')
    image = Image.last

    uploaded_image = Net::HTTP.get(URI image.attachment.url)
    assert_match md5_data(File.read(File.expand_path("../fixtures/ruby.png", __FILE__))), md5_data(uploaded_image)

    put "/image/edit/#{image.id}", attachment: file_upload('rails.png')

    new_image = Net::HTTP.get(URI Image.last.attachment.url)
    assert last_response.ok?
    assert_match md5_data(File.read(File.expand_path("../fixtures/rails.png", __FILE__))), md5_data(new_image)
  end
end
