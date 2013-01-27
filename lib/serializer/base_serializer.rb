# coding: utf-8

class BaseSerializer

    NIL_DATA_ERROR     = 'nil data is inputted.'
    NOT_OVERRIDE_ERROR = 'template method is not overriden.'

    public
    def serialize(data)
        raise NIL_DATA_ERROR if data.nil?
        do_serialize(data)
    end

    def deserialize
        do_deserialize
    end

    protected
    def do_serialize(data)
        raise NOT_OVERRIDE_ERROR
    end

    def do_deserialize
        raise NOT_OVERRIDE_ERROR
    end
end
