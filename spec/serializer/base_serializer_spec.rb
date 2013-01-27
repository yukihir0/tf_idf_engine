# coding: utf-8
require File.expand_path('spec/spec_helper')

describe BaseSerializer do
    context 'init' do
        before(:each) do
            @serializer = BaseSerializer.new
        end
        
        describe '#serialize' do
            context 'when nil data input' do
                it 'raise error' do
                    expect { @serializer.serialize(nil)
                    }.to raise_error(RuntimeError, BaseSerializer::NIL_DATA_ERROR)
                end
            end

            context 'when data input' do
                it 'raise error' do
                    expect { @serializer.serialize({'id_001' => {'a' => 1.0}})
                    }.to raise_error(RuntimeError, BaseSerializer::NOT_OVERRIDE_ERROR)
                end
            end
        end

        describe '#de_serialize' do
            context 'when call' do
                it 'raise error' do
                    expect { @serializer.deserialize
                    }.to raise_error(RuntimeError, BaseSerializer::NOT_OVERRIDE_ERROR)
                end
            end
        end
    end
end
