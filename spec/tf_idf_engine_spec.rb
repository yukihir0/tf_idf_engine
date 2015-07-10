# coding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe TfIdfEngine do
  context 'uninitialized' do
    describe '#initialize' do
      context 'when call' do
        it 'initialized' do
          engine     = TfIdfEngine.new
          t_o        = engine.instance_eval('@t_o')
          calculator = engine.instance_eval('@calculator')

          t_o.should == {}
          calculator.instance_of?(TfIdfCalculator).should be_truthy
        end
      end
    end
  end

  context 'have no doc' do
    before(:each) do
      @engine = TfIdfEngine.new
      @id1    = 'id_001'
      @doc1   = %w(a b)
    end

    describe '#input' do
      context 'when nil id, nil doc input' do
        it 'raise error' do
          expect { @engine.input(nil, nil)
          }.to raise_error(RuntimeError, TfIdfEngine::NIL_ID_ERROR)
        end
      end

      context 'when nil id input' do
        it 'raise error' do
          expect { @engine.input(nil, @doc1)
          }.to raise_error(RuntimeError, TfIdfEngine::NIL_ID_ERROR)
        end
      end

      context 'when empty id input' do
        it 'raise error' do
          expect { @engine.input('', @doc1)
          }.to raise_error(RuntimeError, TfIdfEngine::NIL_ID_ERROR)
        end
      end

      context 'when nil doc input' do
        it 'raise error' do
          expect { @engine.input(@id1, nil)
          }.to raise_error(RuntimeError, TfIdfEngine::NIL_DOC_ERROR)
        end
      end

      context 'when empty doc input' do
        it 'raise error' do
          expect { @engine.input(@id1, '')
          }.to raise_error(RuntimeError, TfIdfEngine::NIL_DOC_ERROR)
        end
      end

      context 'when not array doc input' do
        it 'raise error' do
          expect { @engine.input(@id1, 'doc')
          }.to raise_error(RuntimeError, TfIdfEngine::NOT_ARRAY_DOC_ERROR)
        end
      end

      context 'when id, doc input' do
        it 't_o' do
          expected = {"id_001" => {"a" => 1, "b" => 1}}

          @engine.input(@id1, @doc1)
          t_o = @engine.instance_eval('@t_o')
          t_o.should == expected
        end
      end
    end

    describe '#analyze_all' do
      context 'when call' do
        it 'tf_idf' do
          tf_idf = @engine.analyze_all
          tf_idf.should == {}
        end
      end
    end

    describe '#analyze' do
      context 'when nil doc input' do
        it 'raise error' do
          expect { @engine.analyze(nil)
          }.to raise_error(RuntimeError, TfIdfEngine::NIL_DOC_ERROR)
        end
      end

      context 'when empty doc input' do
        it 'raise error' do
          expect { @engine.analyze('')
          }.to raise_error(RuntimeError, TfIdfEngine::NIL_DOC_ERROR)
        end
      end

      context 'when doc input' do
        it 'tf_idf' do
          expected1 = {"a" => 0.0, "b" => 0.0}
          tf_idf_once = @engine.analyze(@doc1)
          tf_idf_once.should == expected1

          expected2 = {}
          tf_idf = @engine.analyze_all
          tf_idf.should == expected2
        end
      end
    end

    describe '#used?' do
      context 'when nil id input' do
        it 'false' do
          @engine.send(:used?, nil).should be_falsey
        end
      end

      context 'when empty id input' do
        it 'false ' do
          @engine.send(:used?,'').should be_falsey
        end
      end

      context 'when id_001 input' do
        it 'false' do
          @engine.send(:used?, @id1).should be_falsey
        end
      end
    end
  end

  context 'have 1 doc' do
    before(:each) do
      @engine = TfIdfEngine.new
      @id1    = 'id_001'
      @doc1   = %w(a b)
      @id2    = 'id_002'
      @doc2   = %w(b c)
      @engine.input(@id1, @doc1)
    end

    describe '#input' do
      context 'when nil id, nil doc input' do
        it 'raise error' do
          expect { @engine.input(nil, nil)
          }.to raise_error(RuntimeError, TfIdfEngine::NIL_ID_ERROR)
        end
      end

      context 'when nil id input' do
        it 'raise error' do
          expect { @engine.input(nil, @doc1)
          }.to raise_error(RuntimeError, TfIdfEngine::NIL_ID_ERROR)
        end
      end

      context 'when empty id input' do
        it 'raise error' do
          expect { @engine.input('', @doc1)
          }.to raise_error(RuntimeError, TfIdfEngine::NIL_ID_ERROR)
        end
      end

      context 'when nil doc input' do
        it 'raise error' do
          expect { @engine.input(@id1, nil)
          }.to raise_error(RuntimeError, TfIdfEngine::NIL_DOC_ERROR)
        end
      end

      context 'when empty doc input' do
        it 'raise error' do
          expect { @engine.input(@id1, '')
          }.to raise_error(RuntimeError, TfIdfEngine::NIL_DOC_ERROR)
        end
      end

      context 'when not array doc input' do
        it 'raise error' do
          expect { @engine.input(@id1, 'doc')
          }.to raise_error(RuntimeError, TfIdfEngine::NOT_ARRAY_DOC_ERROR)
        end
      end

      context 'when id_001 input' do
        it 'raise error' do
          expect { @engine.input(@id1, @doc1)
          }.to raise_error(RuntimeError, TfIdfEngine::ALREADY_USED_ID_ERROR)
        end
      end

      context 'when new id input' do
        it 't_o' do
          expected = {"id_001" => {"a" => 1, "b" => 1},
                      "id_002" => {"b" => 1, "c" => 1}}

          @engine.input(@id2, @doc2)
          t_o = @engine.instance_eval('@t_o').should == expected
        end
      end
    end

    describe '#analyze_all' do
      context 'when call' do
        it 'tf_idf' do
          expected = {'id_001' => {'a' => 0.0, 'b' => 0.0}}

          tf_idf = @engine.analyze_all
          tf_idf.should == expected
        end
      end
    end

    describe '#analyze' do
      context 'when nil doc input' do
        it 'raise error' do
          expect { @engine.analyze(nil)
          }.to raise_error(RuntimeError, TfIdfEngine::NIL_DOC_ERROR)
        end
      end

      context 'when empty doc input' do
        it 'raise error' do
          expect { @engine.analyze('')
          }.to raise_error(RuntimeError, TfIdfEngine::NIL_DOC_ERROR)
        end
      end

      context 'when doc input' do
        it 'tf_idf' do
          expected1 = {"b" => 0.0, "c" => 0.1505149978319906}
          tf_idf_once = @engine.analyze(@doc2)
          tf_idf_once.should == expected1

          expected2 = {"id_001"=>{"a"=>0.0, "b"=>0.0}}
          tf_idf = @engine.analyze_all
          tf_idf.should == expected2
        end
      end
    end

    describe '#used?' do
      context 'when nil id input' do
        it 'false' do
          @engine.send(:used?, nil).should be_falsey
        end
      end

      context 'when empty id input' do
        it 'false ' do
          @engine.send(:used?, '').should be_falsey
        end
      end

      context 'when id_001 input' do
        it 'true' do
          @engine.send(:used?, @id1).should be_truthy
        end
      end

      context 'when id_002 input' do
        it 'false' do
          @engine.send(:used?, @id2).should be_falsey
        end
      end
    end
  end
end
