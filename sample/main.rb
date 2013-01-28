# coding: utf-8
require 'tf_idf_engine'

def print_tf_idf
    # analyze all result
    tf_idf = @engine.analyze_all
    puts "tf_idf: #{tf_idf}", ''
end

# initialize engine with file_serializer
@engine = TfIdfEngine.new(TfIdfEngine::FILE_SERIALIZER, file_path: './', file_name: 'sample-test.data')

# initialize engine with no serizlizer
# @engine = TfIdfEngne.new

# input documents
@engine.input('id_001', %w(a b))
@engine.input('id_002', %w(b c c))
print_tf_idf

# save result and clear
@engine.save
@engine.clear
print_tf_idf

# load result
@engine.load
print_tf_idf

# analyze result of specified id
tf_idf = @engine.analyze('id_001')
puts "tf_idf['id_001']: #{tf_idf}"
