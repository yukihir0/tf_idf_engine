# coding: utf-8
require 'tf_idf_engine/version'
require 'calculator/tf_idf_calculator'
require 'serializer/serializer_factory'
require 'serializer/serializer_type'

class TfIdfEngine
    include SerializerType

    NIL_ID_ERROR          = 'nil id is  inputted.'
    NIL_DOC_ERROR         = 'nil doc is inputted.'
    NOT_ARRAY_DOC_ERROR   = 'doc that is not an instance of array is inputted.'
    ALREADY_USED_ID_ERROR = 'already used id is inputted.'
    UNUSED_ID_ERROR       = 'unused id is inputted.'

    public
    def initialize(serializer_type = nil, options = {})
        clear
        @calculator = TfIdfCalculator.instance
        factory     = SerializerFactory.instance
        @serializer = factory.create_serializer(serializer_type, options)
    end

    def input(id, doc)
        raise NIL_ID_ERROR if id.nil? || id.empty?
        raise NIL_DOC_ERROR if doc.nil?
        raise NOT_ARRAY_DOC_ERROR unless doc.instance_of?(Array)
        raise ALREADY_USED_ID_ERROR if exist?(id)

        @have_unprocessed_doc = true
        @t_o_all[id] = @calculator.term_occurrence(doc)
    end

    def analyze_all
        @tf_all = @calculator.term_frequency_all(@t_o_all)
        calculate_tf_idf
    end

    def analyze(id)
        raise NIL_ID_ERROR if id.nil? || id.empty?
        raise UNUSED_ID_ERROR unless exist?(id)

        tf      = @calculator.term_frequency(@t_o_all[id])
        @tf_all = {id => tf}
        calculate_tf_idf
    end

    def exist?(id)
        @t_o_all.keys.include?(id)
    end

    def clear
        @have_unprocessed_doc = false
        @t_o_all = Hash.new
        @idf_al  = Hash.new
    end

    def save
        @serializer.serialize(@t_o_all)
    end

    def load
        @t_o_all = @serializer.deserialize
    end

    private
    def calculate_tf_idf
        if @have_unprocessed_doc
            @idf_all = @calculator.inverse_document_frequency(@t_o_all)
            @have_unprocessed_doc = false
        end
        @calculator.tf_idf(@tf_all, @idf_all)
    end
end
