module Serializers
  class Mongoid
    def initialize(record)
      @record_attrs = record.attributes
    end

    def serialize(id_attr: :id)
      record_attrs.delete "_id"
      record_attrs["id"] = record_attrs.delete id_attr.to_s
      record_attrs
    end

    private
    attr_reader :record_attrs
  end
end
