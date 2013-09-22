# encoding: utf-8
require 'dropbox_sdk'

module CarrierWave
  module Storage
    class Dropbox < Abstract

      # Stubs we must implement to create and save
      # files (here on Dropbox)

      # Store a single file
      def store!(file)
        location = uploader.store_path
        location = "/Public/#{location}" if config[:access_type] == "dropbox"

        dropbox_client.put_file(location, file.to_file)
      end

      # Retrieve a single file
      def retrieve!(file)
        CarrierWave::Storage::Dropbox::File.new(uploader, config, uploader.store_path(file), dropbox_client)
      end

      private

      def dropbox_client
        @dropbox_client ||= begin
          session = DropboxSession.new(config[:app_key], config[:app_secret])
          session.set_access_token(config[:access_token], config[:access_token_secret])
          DropboxClient.new(session, config[:access_type])
        end
      end

      def config
        @config ||= {}

        @config[:app_key] ||= uploader.dropbox_app_key
        @config[:app_secret] ||= uploader.dropbox_app_secret
        @config[:access_token] ||= uploader.dropbox_access_token
        @config[:access_token_secret] ||= uploader.dropbox_access_token_secret
        @config[:access_type] ||= uploader.dropbox_access_type || "dropbox"
        @config[:user_id] ||= uploader.dropbox_user_id

        @config
      end

      class File
        include CarrierWave::Utilities::Uri
        attr_reader :path

        def initialize(uploader, config, path, client)
          @uploader, @config, @path, @client = uploader, config, path, client
        end

        def url
          user_id, path = @config[:user_id], @path
          if @config[:access_type] == "dropbox"
            "https://dl.dropboxusercontent.com/u/#{user_id}/#{path}"
          else
            @client.media(path)["url"]
          end
        end

        def delete
          path = "/Public/#{@path}" if @config[:access_type] == "dropbox"
          begin
            @client.file_delete(path)
          rescue DropboxError
          end
        end
      end
    end
  end
end
