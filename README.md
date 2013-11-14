# Carrierwave uploads on Dropbox

This gem allows you to easily upload your medias on Dropbox using the awesome
[Carrierwave](https://github.com/carrierwaveuploader/carrierwave) gem.

## Installation

First, you have to create a [Dropbox app](https://www.dropbox.com/developers/apps).
You can either create a "full dropbox" or "app folder" application. Please see
[this wiki](https://github.com/janko-m/paperclip-dropbox/wiki/Access-types) for
further information and gotchas.

Then, add this line to your application's Gemfile:

~~~ruby
gem 'carrierwave-dropbox'
~~~

And make sure that it get installed running the `bundle` command. Then, you have
to run the `rake authorize` command to authorize your application to access to
your Dropbox.

If you are using Rails, the Rake task is automatically loaded. Otherwise, if you
aren't running a Rails application, first load the task in your `Rakefile`:

~~~ruby
load "carrierwave/dropbox/authorize.rake"
~~~

Then you have to run this task:

~~~bash
rake dropbox:authorize APP_KEY=app_key APP_SECRET=app_secret ACCESS_TYPE=dropbox|app_folder
~~~

Finally, you will get your credentials. Config CarrierWave to make it work with
your Dropbox:

~~~ruby
CarrierWave.configure do |config|
  config.dropbox_app_key = ENV["APP_KEY"]
  config.dropbox_app_secret = ENV["APP_SECRET"]
  config.dropbox_access_token = ENV["ACCESS_TOKEN"]
  config.dropbox_access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
  config.dropbox_user_id = ENV["USER_ID"]
  config.dropbox_access_type = "dropbox"
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
