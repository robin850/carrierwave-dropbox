# Carrierwave uploads on Dropbox

This gem allows you to easily upload your medias on Dropbox using the awesome
[CarrierWave](https://github.com/carrierwaveuploader/carrierwave) gem.

## Installation

First, you have to create a [Dropbox app](https://www.dropbox.com/developers/apps).
You can either create a "full dropbox" or "app folder" application. Please see
[this wiki](https://github.com/janko-m/paperclip-dropbox/wiki/Access-types) for
further information and gotchas.

Then, add this line to your application's Gemfile:

~~~ruby
gem 'carrierwave-dropbox'
~~~

Run `bundle`.

Grab your access token for your DB app. To make a DB app / generate token,
go [here](https://www.dropbox.com/developers/apps).

~~~ruby
CarrierWave.configure do |config|
  config.dropbox_access_token = ENV["ACCESS_TOKEN"]
end
~~~

**Note**: It's advisable not to directly store the credentials in your files
especially if you are using a SCM (e.g. git). You should store these values in
[environment variables for instance](https://gist.github.com/canton7/1423106)
like in the above example.

Then you can either specify in your uploader files the storage or define it
globally through `CarrierWave.configure`:

~~~ruby
class ImageUploader < CarrierWave::Uploader::Base
  storage :dropbox
end
~~~

## Notable differences from other storage engines

Unlike typical `CarrierWave` storage engines, we do not assume an uploaded file
will always be at the same path, as DB UI users may move files around. As such,
this version of this gem relies on the file id. There are two significant
implications to this approach:

1. The `#store_path` and `#store_dir` methods are not guaranteed to be accurate
after the initial file upload. We do not overwrite these methods as the end user
will often overwrite these methods to specify where the file should initially
be stored.
1. The default `#filename` method is not accurate, as we are storing the DB id,
rather than the name of the file. I recommend that end users overwrite the
`#filename` method to delegate to the `CarrierWave::Storage::Dropbox::File`
interface. Example:

~~~ruby
MyUploader < CarrierWave::Uploader::Base
  storage :dropbox

  def filename
    if original_filename
      # perform any file name manipulation on initial upload
    elsif file
      file.filename
    end
  end
end
~~~

## Special thanks

This project is highly based on these two gems:

* [paperclip-dropbox](https://github.com/janko-m/paperclip-dropbox)
* [carrierwave-aws](https://github.com/sorentwo/carrierwave-aws)

Thanks to their respective authors and contributors!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Please see the `LICENSE` file for further information.
