# encoding: utf-8
require 'dropbox'

module CarrierWave
  module Storage
    class Dropbox < Abstract

      # Stubs we must implement to create and save
      # files (here on Dropbox)

      # Store a single file
      def store!(file)
        location = "/#{uploader.store_path}"
        dropbox_client.upload(location, file.to_file)
      end

      # Retrieve a single file
      def retrieve!(file)
        CarrierWave::Storage::Dropbox::File.new(uploader, config, uploader.store_path(file), dropbox_client)
      end

      def dropbox_client
        @dropbox_client ||= begin
          ::Dropbox::Client.new(config[:access_token])
        end
      end

      private

      def config
        @config ||= {}

        @config[:access_token] ||= uploader.dropbox_access_token

        @config
      end

      class File
        include CarrierWave::Utilities::Uri
        attr_reader :path

        def initialize(uploader, config, path, client)
          @uploader, @config, @path, @client = uploader, config, path, client
        end

        def url
          metadata, result = @client.get_temporary_link("/#{@path}")
          result
        end

        def delete
          path = @path
          path = "/#{path}"
          begin
            @client.delete(path)
          rescue ::Dropbox::ApiError
          end
        end
      end
    end
  end
end
