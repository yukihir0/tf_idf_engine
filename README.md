# TfIdfEngine [![Build Status](https://travis-ci.org/yukihir0/tf_idf_engine.png?branch=master)](https://travis-ci.org/yukihir0/tf_idf_engine)

'tf_idf_engine' provides feature for calculating TF-IDF by incremental algorithm.

## Requirements

- ruby 1.9

## Install

Add this line to your application's Gemfile:

```
gem 'tf_idf_engine', :github => 'yukihir0/tf_idf_engine'
```

And then execute:

```
% bundle install
```

## How to use

```
engine = TfIdfEngine.new

engine.input('id_001', %w(a b))
engine.input('id_002', %w(b c c))

tf_idf = engine.analyze_all
puts tf_idf
```

For more information, please see [here](https://github.com/yukihir0/tf_idf_engine/blob/master/sample/main.rb).

## License

Copyright &copy; 2013 yukihir0
