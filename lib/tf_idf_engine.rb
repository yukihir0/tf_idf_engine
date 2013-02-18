# coding: utf-8
require 'tf_idf_engine/version'
require 'tf_idf_engine/calculator/tf_idf_calculator'

class TfIdfEngine
    include Calculator

    NIL_ID_ERROR          = 'nil id is  inputted.'
    NIL_DOC_ERROR         = 'nil doc is inputted.'
    NOT_ARRAY_DOC_ERROR   = 'doc that is not an instance of array is inputted.'
    ALREADY_USED_ID_ERROR = 'already used id is inputted.'
    UNUSED_ID_ERROR       = 'unused id is inputted.'

    public
    def initialize
        @t_o        = Hash.new
        @calculator = TfIdfCalculator.instance
    end

    def input(id, doc)
        raise NIL_ID_ERROR if nil_or_empty?(id)
        raise NIL_DOC_ERROR if nil_or_empty?(doc)
        raise NOT_ARRAY_DOC_ERROR unless doc.instance_of?(Array)
        raise ALREADY_USED_ID_ERROR if used?(id)

        @t_o[id] = @calculator.term_occurrence(doc)
    end

    def analyze_all
        tf  = @calculator.term_frequency_all(@t_o)
        idf = @calculator.inverse_document_frequency(@t_o)
        @calculator.tf_idf(tf, idf)
    end
  
    def analyze(doc)
        raise NIL_DOC_ERROR if nil_or_empty?(doc)
        raise NOT_ARRAY_DOC_ERROR unless doc.instance_of?(Array)

        # input tempolary cod
        id = 'ANALYZE_ONCE_ID'
        input(id, doc)
        
        tf     = {id => @calculator.term_frequency(@t_o[id])}
        idf    = @calculator.inverse_document_frequency(@t_o)
        tf_idf = @calculator.tf_idf(tf, idf)
        result = tf_idf[id]
        
        # delete tempolary doc
        @t_o.delete(id)

        result
    end

    private
    def nil_or_empty?(target)
        target.nil? || target.empty?
    end

    def used?(id)
        @t_o.keys.include?(id)
    end
end
