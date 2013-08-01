require 'dropbox_sdk'

module Carrierwave
  module Storage
    class Dropbox < Abstract

      # Stubs we must implement to create and save
      # files (here on Dropbox)

      # Fetch a single file
      def store!(file)
        dropbox_client.put_file(file.path, file.to_file)
      end

      # Fetch the a single file
      def retrieve!(file)
        "https://dl.dropboxusercontent.com/u/#{uploader.dropbox_user_id}/#{file.path}"
      end

      private

      def dropbox_client
        consumer_key    = uploader.dropbox_key
        consumer_secret = uploader.dropbox_secret

        token = DropboxOAuth2FlowNoRedirect.new(consumer_key, consumer_secret)
        DropboxClient.new(token)
      end
    end
  end
end
