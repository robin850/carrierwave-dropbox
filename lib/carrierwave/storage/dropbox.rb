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
        res = dropbox_client.upload(location, file.to_file)
        uploader.model.update_column uploader.mounted_as, res.id
      end

      # Retrieve a single file
      def retrieve!(file_id)
        # allow for use of either path or ID as the file identifier
        id = file_id.match(/^id:/) ? file_id : "/#{uploader.store_path file_id}"
        CarrierWave::Storage::Dropbox::File.new(uploader, config, id, dropbox_client)
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
        attr_reader :file_id

        def initialize(uploader, config, file_id, client)
          @uploader, @config, @file_id, @client = uploader, config, file_id, client
        end

        def file_data
          @file_data ||= @client.get_temporary_link(@file_id)
        end

        def filename
          file_data[0].name
        end

        def url
          file_data[1]
        end

        def delete
          begin
            @client.delete @file_id
          rescue ::Dropbox::ApiError
          end
        end
      end
    end
  end
end
