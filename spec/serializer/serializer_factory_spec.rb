# coding: utf-8
require File.expand_path('spec/spec_helper')

describe SerializerFactory do
    context 'init' do
        before(:each) do
            @factory = SerializerFactory.instance
        end

        describe '#create_serializer' do
            context 'when nil type input' do
                it 'create DummySerializer' do
                    serializer = @factory.create_serializer(nil)
                    serializer.instance_of?(DummySerializer).should be_true
                end
            end

            context 'when empty type input' do
                it 'raise error' do
                    expect {seralizer = @factory.create_serializer('')
                    }.to raise_error(RuntimeError, SerializerFactory::INVALID_TYPE_ERROR)
                end
            end

            context 'when invalid type input' do
                it 'raise error' do
                    expect {seralizer = @factory.create_serializer('invalid type')
                    }.to raise_error(RuntimeError, SerializerFactory::INVALID_TYPE_ERROR)

                end
            end

            context 'when FILE_SERIALIZER(nil file_path) input' do
                it 'raise error' do
                    expect { serializer = @factory.create_serializer(SerializerFactory::FILE_SERIALIZER, file_name: 'serializer_factory_test.data')
                    }.to raise_error(RuntimeError, SerializerFactory::INVALID_FILE_OPTIONS_ERROR)
                end
            end

            context 'when FILE_SERIALIZER(nil file_name) input' do
                it 'raise error' do
                    expect { serializer = @factory.create_serializer(SerializerFactory::FILE_SERIALIZER, file_path: 'spec/serializer')
                    }.to raise_error(RuntimeError, SerializerFactory::INVALID_FILE_OPTIONS_ERROR)
                end
            end

            context 'when FILE_SERIALIZER input' do
                it 'create FileSerializer' do
                    serializer = @factory.create_serializer(SerializerFactory::FILE_SERIALIZER, file_path: 'spec/serializer', file_name:'serializer_factory_test.data')
                    serializer.instance_of?(FileSerializer).should be_true
                end
            end
        end
    end
end
