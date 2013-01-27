# coding: utf-8
require File.expand_path('spec/spec_helper')

describe FileSerializer do
    before(:each) do
        @file_path = 'spec/serializer'
        @file_name = 'file_serializer_test.data'
    end

    context 'initialized failure' do
        describe '#initialize' do
            context 'when nil file_path input' do
                it 'raise error' do
                    expect { FileSerializer.new(nil, @file_name)
                    }.to raise_error(RuntimeError, FileSerializer::NIL_FILE_PATH_ERROR)
                end
            end

            context 'when empty file_path input' do
                it 'raise error' do
                    expect { FileSerializer.new('', @file_name)
                    }.to raise_error(RuntimeError, FileSerializer::NIL_FILE_PATH_ERROR)
                end
            end

            context 'when nil file_name input' do
                it 'raise error' do
                    expect { FileSerializer.new(@file_path, nil)
                    }.to raise_error(RuntimeError, FileSerializer::NIL_FILE_NAME_ERROR)
                end
            end

            context 'when empty file_name input' do
                it 'raise error' do
                    expect { FileSerializer.new(@file_path, '')
                    }.to raise_error(RuntimeError, FileSerializer::NIL_FILE_NAME_ERROR)
                end
            end
        end
    end

    context 'initialized success, not serialized file' do
        before(:each) do
            @serializer = FileSerializer.new(@file_path, @file_name)
        end
        
        describe '#serialize' do
            context 'when nil data input' do
                it 'raise error' do
                    expect { @serializer.serialize(nil)
                    }.to raise_error(RuntimeError, BaseSerializer::NIL_DATA_ERROR)
                end
            end

            context 'when data input' do
                it 'serialize file' do
                    @serializer.serialize({'id_001' => {'a' => 1.0}})
                    File.exist?("#{@file_path}/#{@file_name}").should == true
                end
            end
        end

        describe '#de_serialize' do
            context 'when call' do
                it 'raise error' do
                    expect { @serializer.deserialize
                    }.to raise_error
                end
            end
        end

        after(:each) do
            if File.exist?("#{@file_path}/#{@file_name}")
                File.delete("#{@file_path}/#{@file_name}")
            end
        end
    end

    context 'initialized success, serialized file' do
        before(:each) do
            data = {'id_001' => {'a' => 1.0}}
            @serializer = FileSerializer.new(@file_path, @file_name)
            @serializer.serialize(data)
        end
        
        describe '#serialize' do
            context 'when nil data input' do
                it 'raise error' do
                    expect { @serializer.serialize(nil)
                    }.to raise_error(RuntimeError, BaseSerializer::NIL_DATA_ERROR)
                end
            end

            context 'when data input' do
                it 'serialize file' do
                    @serializer.serialize({'id_002' => {'' => 2.0}})
                    File.exist?("#{@file_path}/#{@file_name}").should == true
                end
            end

        end

        describe '#de_serialize' do
            context 'when call' do
                it 'deserialize file' do
                    expected = {'id_001' => {'a' => 1.0}}
                    data = @serializer.deserialize
                    data.should == expected
                end
            end
        end

        after(:each) do
            if File.exist?("#{@file_path}/#{@file_name}")
                File.delete("#{@file_path}/#{@file_name}")
            end
        end
    end
end
