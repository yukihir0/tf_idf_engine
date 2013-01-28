# coding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe TfIdfEngine do
    context 'have no doc' do
        before(:each) do
            @engine = TfIdfEngine.new
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
                    expect { @engine.input(nil, %w())
                    }.to raise_error(RuntimeError, TfIdfEngine::NIL_ID_ERROR)
                end
            end

            context 'when empty id input' do
                 it 'raise error' do
                    expect { @engine.input('', %w())
                    }.to raise_error(RuntimeError, TfIdfEngine::NIL_ID_ERROR)
                end
            end
 
            context 'when nil doc input' do
                 it 'raise error' do
                    expect { @engine.input('id_001', nil)
                    }.to raise_error(RuntimeError, TfIdfEngine::NIL_DOC_ERROR)
                end
            end
            
            context 'when not array doc input' do
                 it 'raise error' do
                    expect { @engine.input('id_001', 'doc')
                    }.to raise_error(RuntimeError, TfIdfEngine::NOT_ARRAY_DOC_ERROR)
                end
            end

            context 'when id, doc input' do
                it 'not raise error' do
                    expect { @engine.input('id_001', %w(a b))
                    }.to_not raise_error
                end
            end
        end

        describe '#analyze_all' do
            context 'when call' do
                it 'expected {}' do
                    tf_idf = @engine.analyze_all
                    tf_idf.should == {}
                end
            end
        end

        describe 'analyze(id)' do
            context 'when nil id input' do
                it 'raise error' do
                    expect { @engine.analyze(nil)
                    }.to raise_error(RuntimeError, TfIdfEngine::NIL_ID_ERROR)
                end
            end

            context 'when empty id input' do
                it 'raise error' do
                    expect { @engine.analyze('')
                    }.to raise_error(RuntimeError, TfIdfEngine::NIL_ID_ERROR)
                end
            end

            context 'when id input' do
                it 'raise error' do
                    expect { @engine.analyze('id_001')
                    }.to raise_error(RuntimeError, TfIdfEngine::UNUSED_ID_ERROR)
                end
            end
        end

        describe '#clear' do
            context 'when call' do
                it 'clear tf_idf' do
                    @engine.clear
                    tf_idf = @engine.analyze_all
                    tf_idf.should == {}
                end
            end
        end
    end

    context 'have 1 doc' do
        before(:each) do
            @engine = TfIdfEngine.new
            @engine.input('id_001', %w(a b))
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
                    expect { @engine.input(nil, %w())
                    }.to raise_error(RuntimeError, TfIdfEngine::NIL_ID_ERROR)
                end
            end

            context 'when empty id input' do
                 it 'raise error' do
                    expect { @engine.input('', %w())
                    }.to raise_error(RuntimeError, TfIdfEngine::NIL_ID_ERROR)
                end
            end
 
            context 'when nil doc input' do
                 it 'raise error' do
                    expect { @engine.input('id_001', nil)
                    }.to raise_error(RuntimeError, TfIdfEngine::NIL_DOC_ERROR)
                end
            end
            
            context 'when not array doc input' do
                 it 'raise error' do
                    expect { @engine.input('id_001', 'doc')
                    }.to raise_error(RuntimeError, TfIdfEngine::NOT_ARRAY_DOC_ERROR)
                end
            end

            context 'when already have id input' do
                it 'raise error' do
                    expect { @engine.input('id_001', %w(a b))
                    }.to raise_error(RuntimeError, TfIdfEngine::ALREADY_USED_ID_ERROR)
                end
            end

            context 'when new id input' do
                it 'not raise error' do
                    expect { @engine.input('id_002', %w(a b))
                    }.to_not raise_error
                end
            end
        end

        describe '#analyze_all' do
            context 'when call' do
                it 'expected tf_idf' do
                    expected = {'id_001' => {'a' => 0.0, 'b' => 0.0}}

                    tf_idf = @engine.analyze_all
                    tf_idf.should == expected
                end
            end

        end

        describe 'analyze(id)' do
            context 'when nil id input' do
                it 'raise error' do
                    expect { @engine.analyze(nil)
                    }.to raise_error(RuntimeError, TfIdfEngine::NIL_ID_ERROR)
                end
            end

            context 'when empty id input' do
                it 'raise error' do
                    expect { @engine.analyze('')
                    }.to raise_error(RuntimeError, TfIdfEngine::NIL_ID_ERROR)
                end
            end

            context 'when invalid id input' do
                it 'raise error' do
                    expect { @engine.analyze('id_002')
                    }.to raise_error(RuntimeError, TfIdfEngine::UNUSED_ID_ERROR)
                end
            end

            context 'when id input' do
                it 'expected tf_idf' do
                    input    = 'id_001'
                    expected = {'id_001' => {'a' => 0.0, 'b' => 0.0}}

                    tf_idf = @engine.analyze('id_001')
                    tf_idf.should == expected
                end
            end
        end

        describe '#clear' do
            context 'when call' do
                it 'clear tf_idf' do
                    @engine.clear
                    tf_idf = @engine.analyze_all
                    tf_idf.should == {}
                end
            end
        end
    end

    context 'have 2 doc' do
        before(:each) do
            @engine = TfIdfEngine.new
            
            @engine.input('id_001', %w(a b))
            @engine.input('id_002', %w(b c c))
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
                    expect { @engine.input(nil, %w())
                    }.to raise_error(RuntimeError, TfIdfEngine::NIL_ID_ERROR)
                end
            end

            context 'when empty id input' do
                 it 'raise error' do
                    expect { @engine.input('', %w())
                    }.to raise_error(RuntimeError, TfIdfEngine::NIL_ID_ERROR)
                end
            end
 
            context 'when nil doc input' do
                 it 'raise error' do
                    expect { @engine.input('id_001', nil)
                    }.to raise_error(RuntimeError, TfIdfEngine::NIL_DOC_ERROR)
                end
            end
            
            context 'when not array doc input' do
                 it 'raise error' do
                    expect { @engine.input('id_001', 'doc')
                    }.to raise_error(RuntimeError, TfIdfEngine::NOT_ARRAY_DOC_ERROR)
                end
            end

            context 'when already have id(id_001) input' do
                it 'raise error' do
                    expect { @engine.input('id_001', %w(a b))
                    }.to raise_error(RuntimeError, TfIdfEngine::ALREADY_USED_ID_ERROR)
                end
            end

            context 'when already have id(id_002) input' do
                it 'raise error' do
                    expect { @engine.input('id_002', %w(b c c))
                    }.to raise_error(RuntimeError, TfIdfEngine::ALREADY_USED_ID_ERROR)
                end
            end

            context 'when new id input' do
                it 'not raise error' do
                    expect { @engine.input('id_003', %w(d e f))
                    }.to_not raise_error
                end
            end
        end

        describe '#analyze_all' do
            context 'when call' do
                it 'expected tf_idf' do
                    expected = { 'id_001' => {'a' => 0.5*Math::log10(2/1),
                                              'b' => 0.5*Math::log10(2/2)},
                                 'id_002' => {'b' => 1.0/3.0*Math::log10(2/2),
                                              'c' => 2.0/3.0*Math::log10(2/1)}
                               }

                    tf_idf = @engine.analyze_all
                    tf_idf.should == expected
                end
            end
        end

        describe 'analyze(id)' do
            context 'when nil id input' do
                it 'raise error' do
                    expect { @engine.analyze(nil)
                    }.to raise_error(RuntimeError, TfIdfEngine::NIL_ID_ERROR)
                end
            end

            context 'when empty id input' do
                it 'raise error' do
                    expect { @engine.analyze('')
                    }.to raise_error(RuntimeError, TfIdfEngine::NIL_ID_ERROR)
                end
            end

            context 'when invalid id input' do
                it 'raise error' do
                    expect { @engine.analyze('id_003')
                    }.to raise_error(RuntimeError, TfIdfEngine::UNUSED_ID_ERROR)
                end
            end

            context 'when id_001 input' do
                it 'expected tf_idf' do
                    input    = 'id_001'
                    expected = {'id_001' => {'a' => 0.5*Math::log10(2/1),
                                             'b' => 0.5*Math::log10(2/2)}
                               }

                    tf_idf = @engine.analyze('id_001')
                    tf_idf.should == expected
                end
            end

            context 'when id_002 input' do
                it 'expected tf_idf' do
                    input    = 'id_002'
                    expected = {'id_002' => {'b' => 1.0/3.0*Math::log10(2/2),
                                             'c' => 2.0/3.0*Math::log10(2/1)}
                                            }

                    tf_idf = @engine.analyze('id_002')
                    tf_idf.should == expected
                end
            end
        end

        describe '#clear' do
            context 'when call' do
                it 'clear tf_idf' do
                    @engine.clear
                    tf_idf = @engine.analyze_all
                    tf_idf.should == {}
                end
            end
        end
    end
end
