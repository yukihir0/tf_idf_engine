# coding: utf-8
require 'tf_idf_engine'

# initialize engine
@engine = TfIdfEngine.new

# input documents
@engine.input('id_001', %w(a b))
@engine.input('id_002', %w(b c c))

puts "--- #analyze_all ---"
tf_idf_all = @engine.analyze_all
puts tf_idf_all, ''

puts "--- #analyze(%w(b c d) ---"
tf_idf = @engine.analyze(%w(b c d))
puts tf_idf, ''
