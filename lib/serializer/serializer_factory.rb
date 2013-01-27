# coding: utf-8
require 'singleton'
require 'serializer/serializer_type'
require 'serializer/dummy_serializer'
require 'serializer/file_serializer'

class SerializerFactory
    include Singleton
    include SerializerType

    INVALID_TYPE_ERROR         = 'invalid serializer_type is inputted.'
    INVALID_FILE_OPTIONS_ERROR = 'invalid file_serializer options are inputted.'

    public
    def create_serializer(type, options = {})
        case type
        when nil
            serializer = DummySerializer.new
        when FILE_SERIALIZER
            raise INVALID_FILE_OPTIONS_ERROR unless have_file_path_and_name?(options)
            serializer = FileSerializer.new(options[:file_path], options[:file_name])
        else
            raise INVALID_TYPE_ERROR
        end
    end

    private
    def have_file_path_and_name?(options)
        options.keys.include?(:file_path) && options.keys.include?(:file_name)
    end
end
