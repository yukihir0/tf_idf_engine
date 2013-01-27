# coding: utf-8
require 'base64'
require 'serializer/base_serializer'

class FileSerializer < BaseSerializer

    NIL_FILE_PATH_ERROR = 'nil file_path is inputted.'
    NIL_FILE_NAME_ERROR = 'nil file_name is inputted.'

    public
    def initialize(file_path, file_name)
        raise NIL_FILE_PATH_ERROR if file_path.nil? || file_path.empty?
        raise NIL_FILE_NAME_ERROR if file_name.nil? || file_name.empty?

        @file_path = file_path
        @file_name = file_name
    end

    protected
    def do_serialize(target)
        encoded_target = Base64.encode64(Marshal.dump(target))

        File.open("#{@file_path}/#{@file_name}", 'w') { |file|
            file << encoded_target
        }
    end

    def do_deserialize
        encoded_target = File.open("#{@file_path}/#{@file_name}", 'r').read
        decoded_target = Marshal.load(Base64.decode64(encoded_target))
    end
end

