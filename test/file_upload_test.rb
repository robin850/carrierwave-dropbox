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

    assert_match 'ruby.png', image.attachment.url

    put "/image/edit/#{image.id}", attachment: file_upload('rails.png')

    assert last_response.ok?
    assert_match 'rails.png', Image.last.attachment.url
  end
end
