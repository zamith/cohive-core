module Serializers
  class Pipeline
    def initialize(object)
      @object = object
    end

    def serialize(attrs_method: :instance_variables)
      attributes = object.public_send(attrs_method)
      get_real_attributes_from attributes
    end

    private
    attr_reader :object

    def get_real_attributes_from(attributes)
      if attributes.is_a? Hash
        attributes
      else
        create_attributes_hash attributes
      end
    end

    def create_attributes_hash(attributes)
      attributes.inject({}) do |value, ivar|
        attribute_name = var_name_to_attribute_name(ivar)
        value[attribute_name] = object.public_send(attribute_name)
        value
      end
    end

    def var_name_to_attribute_name(variable_name)
      variable_name.to_s.tr('@', '').to_sym
    end
  end
end
